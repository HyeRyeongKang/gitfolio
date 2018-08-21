class CreateGraphs < ActiveRecord::Migration
  def change
    create_table :graphs do |t|
      t.integer :gid
      t.string :lang

      t.timestamps null: false
    end
  end
end
