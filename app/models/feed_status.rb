# == Schema Information
#
# Table name: feed_status
#
#  id    :integer          not null, primary key
#  name  :string(255)      not null
#  label :string(255)      not null
#

class FeedStatus < ActiveRecord::Base
  self.table_name="feed_status"

  def self.red
    @red ||= FeedStatus.find_by(name: 'red') || raise("db seeded")
  end
  def self.yellow
    @yellow ||= FeedStatus.find_by(name: 'yellow') || raise("db seeded")
  end
  def self.green
    @green ||= FeedStatus.find_by(name: 'green') || raise("db seeded")
  end
end
