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

  has_many :feed_subscriptions
  attr_accessor :user_subscription #for the resource

  scope :unpaused, -> {
    where(paused_at: nil)
  }
  
  def latest_entry_id
    stories.last.try(:entry_id)
  end

  def last_modified!(_last_modified)
    self.last_fetched_at=_last_modified
    save!
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
    self.status = FeedStatus.green
    self.save!
  end
  def fail!
    self.last_failed_at=Time.now
    self.last_success_count=0
    self.last_failed_count = (self.last_failed_count || 0) + 1
    if last_failed_count < 3
      self.status = FeedStatus.yellow
    else
      self.status = FeedStatus.red
    end
    self.save!
  end
end
