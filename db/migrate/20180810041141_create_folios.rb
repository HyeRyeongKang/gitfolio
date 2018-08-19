class CreateFolios < ActiveRecord::Migration
  def change
    create_table :folios do |t|

      t.timestamps null: false
    end
  end
end
