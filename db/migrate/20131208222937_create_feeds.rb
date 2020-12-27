class CreateFeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :feeds do |t|
      t.string :name    ,:null => false
      t.text :url, :null => false
      t.timestamp :last_fetched_at
      t.integer :feed_status_id, :null => false
      t.timestamps
      t.timestamp :last_success_at  
      t.integer   :last_success_count
      t.integer   :last_failed_count
      t.timestamp :last_failed_at
    end
    add_index :feeds, :url, unique: true
    add_foreign_key :feeds,:feed_status
  end
end
