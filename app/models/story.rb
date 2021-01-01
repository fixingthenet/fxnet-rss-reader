# == Schema Information
#
# Table name: stories
#
#  id         :bigint           not null, primary key
#  title      :text
#  permalink  :text
#  body       :text
#  entry_id   :text
#  feed_id    :integer          not null
#  published  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Story < ActiveRecord::Base
  belongs_to :feed
  has_many :user_opens
  validates_uniqueness_of :entry_id, :scope => :feed_id

  attr_accessor :user_open

  scope :base, lambda { |the_user|
    includes(:feed)
    .select('stories.*, user_opens.last_opened_at as last_opened_at, user_opens.read_later_at as read_later_at')
    .order("id desc")
    .left_outer_joins(:user_opens)
    .where(["user_opens.user_id=? or user_opens.user_id is null",the_user.id])
  }
  def self.create_from_raw(feed, entry)
    #might fail!
    Story.create(:feed => feed,
                 :title => entry.title,
                 :permalink => entry.url,
                 :raw_body => entry,
                 :is_read => false,
                 :is_starred => false,
                 :published => entry.published || Time.now,
                 :entry_id => entry.id)

  end

  scope :xfilter, lambda { |filter, user|
    if filter.read_later? || filter.unread?
      sc=joins("LEFT JOIN user_opens ON stories.id=user_opens.story_id").where(["user_opens.user_id=?", user.id])

      if filter.read_later?
        sc=sc.where("user_opens.read_later_at is not null")
      end
      if filter.unread?
        sc=sc.where("user_opens.last_opened_at is null")
      end
      sc
    end
  }

  def headline
    self.title.nil? ? UNTITLED : strip_html(self.title)[0, 100]
  end

  def lead
    strip_html(self.body)[0, 600]
  end

  def source
    self.feed.name
  end

  def pretty_date
    I18n.l(self.published)
  end

  def seen_text
    user_open.opened? ? I18n.l(user_open.last_opened_at) : 'new'
  end

end
