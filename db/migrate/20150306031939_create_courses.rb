class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :user
      t.

      t.timestamps null: false
    end
  end
end
