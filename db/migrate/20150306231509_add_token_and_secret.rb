class AddTokenAndSecret < ActiveRecord::Migration
  def change
    add_column :token, :authorization
    add_column :secret, :authorization
  end
end
