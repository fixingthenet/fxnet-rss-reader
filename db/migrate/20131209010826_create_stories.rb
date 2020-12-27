class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.text :title
      t.text :permalink
      t.text :body
      t.text :entry_id

      t.integer :feed_id, :null => false
      t.timestamp :published

      t.timestamps
    end
    add_index :stories, [:permalink, :feed_id], unique: true
    add_foreign_key :stories, :feeds
  end
end
