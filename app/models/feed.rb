# == Schema Information
#
# Table name: feeds
#
#  id                 :bigint           not null, primary key
#  name               :string           not null
#  url                :text             not null
#  last_fetched_at    :datetime
#  feed_status_id     :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  last_success_at    :datetime
#  last_success_count :integer
#  last_failed_count  :integer
#  last_failed_at     :datetime
#

class Feed < ActiveRecord::Base
  has_many :stories, :dependent => :destroy
  belongs_to :feed_status
  belongs_to :status, :class_name => 'FeedStatus', :foreign_key => 'feed_status_id'
  attr_accessor :user_subscription #for the resource
  def latest_entry_id
    stories.last.try(:entry_id)
  end

  def last_modified!(_last_modified)
    self.last_fetched_at=_last_modified
    save!
  end

  def status!(status_name)

  end

  #this is called by a script (delayed to be run in the background)
  def fetch
    fetcher=FeedFetcher.new(self)
    inserted=fetcher.run
    logger.info("Feed: #{name} new stories: #{inserted}")
  end

  def success!
    self.last_success_at=Time.now
    self.last_failed_count=0
    self.last_success_count = (self.last_success_count || 0) + 1
    self.save!
  end
  def fail!
    self.last_failed_at=Time.now
    self.last_success_count=0
    self.last_failed_count = (self.last_failed_count || 0) + 1
    self.save!
  end
end
