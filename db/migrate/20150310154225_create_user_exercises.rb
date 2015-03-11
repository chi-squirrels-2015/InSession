class CreateUserExercises < ActiveRecord::Migration
  def change
    create_table :user_exercises do |t|
      t.references :user, index: true
      t.references :exercise, index: true
      t.boolean     :struggling, default: false
      t.string      :maximum_exercise_progress
      t.datetime    :last_done

      t.timestamps null: false
    end
  end
end



