class CreateFolios < ActiveRecord::Migration
  def change
    create_table :folios do |t|
      
      t.string :user_id
      t.string :gid

      t.timestamps null: false
    end
  end
end
