class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :email, :string
    add_column :street_address, :string
    add_column :city, :string
    add_column :zip_code, :integer
  end
end
