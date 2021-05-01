class CreateUserOpens < ActiveRecord::Migration[5.1]
  def self.up
    create_table :story_opens do |t|
      t.timestamp :last_opened_at
      t.timestamp :read_later_at
      t.integer :user_id,:null => false
      t.integer :story_id,:null => false
    end
    add_foreign_key :story_opens, :users
    add_foreign_key :story_opens, :stories
    add_index :story_opens, [:user_id,:story_id],:unique => true
    add_index :story_opens, :read_later_at
  end
end
