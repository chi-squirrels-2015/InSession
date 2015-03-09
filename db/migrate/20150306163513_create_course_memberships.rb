class CreateCourseMemberships < ActiveRecord::Migration
  def change
    create_table :course_memberships do |t|
         t.references :user, index: true
         t.references :course, index: true
         t.boolean    :struggling, default: false
         t.string     :maximum_exercise_progress
         t.datetime   :last_done
    end
  end
end
