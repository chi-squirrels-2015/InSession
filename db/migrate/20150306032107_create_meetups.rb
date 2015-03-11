class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.references :course, index: true     
      t.references :organizer, index: true 
      t.time  :begin_time
      t.time  :end_time
      t.date  :scheduled_date
      t.references :venue, index: true
      t.boolean   :remote
      t.string    :title
      t.text      :description
      t.timestamps null: false
    end
  end
end
