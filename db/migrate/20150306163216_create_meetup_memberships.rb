class CreateMeetupMemberships < ActiveRecord::Migration
  def change
    create_table :meetup_memberships do |t|
      t.references :user, index: true
      t.references :meetup, index: true
      
      t.timestamps  
    endn
