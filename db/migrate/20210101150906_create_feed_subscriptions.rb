class CreateFeedSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :feed_subscriptions do |t|
      t.timestamps
    end
    add_reference :feed_subscriptions, :feed, index: true
    add_reference :feed_subscriptions, :user, index: true
  end
end
