class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :course_memberships
      t.integer    :organization_course_id
      t.string     :title
      t.string     :organization
      t.text       :description
      t.datetime   :start_date
      t.datetime   :end_date
      t.references :subject

      t.timestamps null: false
    end
  end
end
