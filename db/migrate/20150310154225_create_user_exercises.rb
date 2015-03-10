class CreateUserExercises < ActiveRecord::Migration
  def change
    create_table :user_exercises do |t|
       t.references :user, index: true
       t.references :exercise, index: true

      t.timestamps null: false
    end
  end
end
