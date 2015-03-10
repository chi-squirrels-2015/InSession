class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.references :course, index: true     
      t.references :organizer, index: true 
      t.datetime  :begin_time
      t.datetime  :end_time
      t.references :venue, index: true
      t.boolean   :remote
      t.string    :title
      t.text      :description
      t.timestamps null: false
    end
  end
end
