class AddFeedSubscribersCountToFeeds < ActiveRecord::Migration[6.1]
  def change
    add_column :feeds, :feed_subscriptions_count, :integer, default: 0
  end
end
