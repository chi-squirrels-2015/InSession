class AddTokenAndSecret < ActiveRecord::Migration
  def change
    add_column :authorizations, :user_token, :string
    add_column :authorizations, :user_secret, :string
    add_column :authorizations, :provider_id, :string
  end
end
