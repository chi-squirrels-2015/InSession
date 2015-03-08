class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :first_name
      t.string      :last_name
<<<<<<< HEAD
=======
      t.string      :name
      t.references  :course
>>>>>>> 3efbc970d7533c762335cbc85d99e552ca5fea95
      t.text        :bio
      t.string      :preferred_language

      t.timestamps null: false
    end
  end
end
