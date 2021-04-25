class CreateProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :oidc_providers do |t|
      t.belongs_to :users
      t.string :issuer, :jwks_uri, :name, :identifier, :secret, :scopes_supported, :host, :scheme
      t.string :authorization_endpoint, :token_endpoint, :userinfo_endpoint
      t.boolean :dynamic, default: false
      t.datetime :expires_at
      t.timestamps
    end
  end
end
