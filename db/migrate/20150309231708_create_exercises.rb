class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string      :title
      t.text        :description
      t.references  :course

      t.timestamps null: false
    end
  end
end
