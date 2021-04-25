class CreateOpenIds < ActiveRecord::Migration[5.1]
  def change
    create_table :oidc_open_ids do |t|
      t.belongs_to :users
      t.belongs_to :provider
      t.string :identifier
      t.string :access_token, limit: 2048
      t.string :id_token, limit: 2048
      t.timestamps
    end
  end
end
