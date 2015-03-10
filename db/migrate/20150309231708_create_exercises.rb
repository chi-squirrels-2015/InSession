class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string      :title
      t.text        :description
      t.references  :course
      t.boolean     :struggling, default: false
      t.string      :maximum_exercise_progress
      t.datetime    :last_done

      t.timestamps null: false
    end
  end
end
