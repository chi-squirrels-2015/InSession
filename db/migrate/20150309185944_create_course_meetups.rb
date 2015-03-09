class CreateCourseMeetups < ActiveRecord::Migration
  def change
    create_table :course_meetups do |t|
      t.references :course, index: true
      t.references :meetup, index: true
    end
  end
end
