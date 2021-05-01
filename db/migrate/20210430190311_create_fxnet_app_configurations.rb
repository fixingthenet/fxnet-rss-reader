class CreateFxnetAppConfigurations < ActiveRecord::Migration[6.1]
  def change
    create_table :app_configurations, id: :uuid do |t|
      t.jsonb :configuration, default: {}, null: false
      t.jsonb :secrets, default: {}, null: false
      t.timestamps
    end
  end
end
