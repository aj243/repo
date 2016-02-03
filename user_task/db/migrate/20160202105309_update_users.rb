class UpdateUsers < ActiveRecord::Migration
  def change
  	change_column :users, :phone_number, :string
  	remove_column :users, :username
  end
end
