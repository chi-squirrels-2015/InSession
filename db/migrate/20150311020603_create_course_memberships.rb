class CreateCourseMemberships < ActiveRecord::Migration
  def change
    create_table :course_memberships do |t|
      t.references :course, index: true
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
