class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :hours_of_operation
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :full_street_address
      t.string :phone
      t.string :website
      t.string :venue_type
    end
  end
end
