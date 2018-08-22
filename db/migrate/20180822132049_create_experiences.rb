class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :usernick
      t.string :name
      t.string :work
      t.string :start
      t.string :end
      t.string :content
      t.string :git

      t.timestamps null: false
    end
  end
end
