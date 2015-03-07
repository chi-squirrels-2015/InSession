class CreateProvider < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :site
      t.string :key
      t.string :secret

      t.timestamps
    end
  end
end
