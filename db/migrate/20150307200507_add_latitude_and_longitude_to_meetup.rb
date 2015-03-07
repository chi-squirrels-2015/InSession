class AddLatitudeAndLongitudeToMeetup < ActiveRecord::Migration
  def change
    add_column :meetups, :latitude, :float
    add_column :meetups, :longitude, :float
  end
end
