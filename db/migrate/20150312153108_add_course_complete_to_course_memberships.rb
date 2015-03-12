class AddCourseCompleteToCourseMemberships < ActiveRecord::Migration
  def change
    add_column :course_memberships, :completed, :boolean, :default => true
  end
end
