# == Schema Information
#
# Table name: feeds
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  url             :text             not null
#  last_fetched_at :datetime
#  feed_status_id  :integer          not null
#  created_at      :datetime
#  updated_at      :datetime
#

class Feed < ActiveRecord::Base
  has_many :stories, :dependent => :destroy
  belongs_to :status, :class_name => 'FeedStatus', :foreign_key => 'feed_status_id'

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
