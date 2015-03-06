class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :first_name
      t.string      :last_name
      t.string      :email
      t.string      :password
      t.string      :password_confirmation
      t.references  :course
      t.text        :bio
      t.string      :preferred_language

      t.timestamps null: false
    end
  end
end
