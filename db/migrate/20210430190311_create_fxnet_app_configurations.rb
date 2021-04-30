class CreateFxnetAppConfigurations < ActiveRecord::Migration[6.1]
  def change
    create_table :app_configurations do |t|
      t.string :identifier, null: false
      t.jsonb :configuration, default: {}
      t.jsonb :secrets, default: {}
      t.timestamps
    end
    add_index :app_configurations, :identifier, unique: true
  end
end
