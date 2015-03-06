class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.references :course, index: true
      t.timestamps null: false
    end
  end
end
