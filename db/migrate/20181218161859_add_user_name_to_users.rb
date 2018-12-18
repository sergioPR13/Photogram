class AddUserNameToUsers < ActiveRecord::Migration[5.2]
  add_index :users, :user_name, unique: true
  def change
    add_column :users, :user_name, :string
  end
end
