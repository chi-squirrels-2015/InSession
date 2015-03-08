class CreateCourseMemberships < ActiveRecord::Migration
  def change
    create_table :course_memberships do |t|
     t.references :user, index: true
     t.references :course, index: true

   end
 end
end
