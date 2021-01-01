# == Schema Information
#
# Table name: feed_status
#
#  id    :bigint           not null, primary key
#  name  :string           not null
#  label :string           not null
#

class FeedStatus < ActiveRecord::Base
  self.table_name="feed_status"

  def self.red
    @red ||= (FeedStatus.find_by(name: 'red') || raise("no db seeded"))
  end
  def self.yellow
    @yellow ||= (FeedStatus.find_by(name: 'yellow') || raise("no db seeded"))
  end
  def self.green
    @green ||= (FeedStatus.find_by(name: 'green') || raise("no db seeded"))
  end
end
