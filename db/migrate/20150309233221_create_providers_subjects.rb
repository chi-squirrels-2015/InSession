class CreateProvidersSubjects < ActiveRecord::Migration
  def change
    create_table :providers_subjects do |t|
      t.references :provider
      t.references :subject

      t.timestamps null: false
    end
  end
end
