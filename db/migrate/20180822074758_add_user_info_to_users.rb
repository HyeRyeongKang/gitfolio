class AddUserInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :age, :integer
    add_column :users, :phone, :string
    add_column :users, :job, :string
    add_column :users, :address, :string
    add_column :users, :github, :string
    add_column :users, :nick, :string, unique: true
  end
end
