class AddPausedAtToFeeds < ActiveRecord::Migration[6.1]
  def change
    add_column :feeds, :paused_at, :timestamp
    add_index :feeds, :paused_at
  end
end
