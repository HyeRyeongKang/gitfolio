class CreateReadmes < ActiveRecord::Migration
  def change
    create_table :readmes do |t|
      t.text :readme
      t.integer :rid
      t.integer :gid

      t.timestamps null: false
    end
  end
end
