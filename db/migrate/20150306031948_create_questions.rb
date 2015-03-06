class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string     :title
      t.text       :content
      t.references :user, index: true
      t.references  :course, index: true
      
      t.timestamps null: false
    end
  end
end
