# This migration comes from authentication (originally 20130106012440)
class ChangeUserPhoneNumberLengthAndMakeUnique < ActiveRecord::Migration
  def up
  	change_column :authentication_users, :phone_number, :string, :limit => 12
  	add_index :authentication_users, :phone_number, :unique => true
  end

  def down
  	change_column :authentication_users, :phone_number, :string, :limit => 10
  	remove_index :authentication_users, :column => :phone_number
  end
end
