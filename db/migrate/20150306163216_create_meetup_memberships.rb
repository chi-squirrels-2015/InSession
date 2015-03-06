class CreateMeetupMemberships < ActiveRecord::Migration
  def change
    create_table :meetup_memberships do |t|
      t.references :user, index: true
      t.references :meetup, index: true
      t.references :organizer, index: true 
      t.datetime  :begin_time
      t.datetime  :end_time
      t.references :venue, index: true
        
      end
    end
  end
end
