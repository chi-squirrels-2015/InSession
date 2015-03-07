class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.references :provider
      t.string     :user_token
      t.string     :user_secret
      t.string     :uid
      t.references :user

      t.timestamps null: false
    end
  end
end
