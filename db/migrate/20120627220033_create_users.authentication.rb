# This migration comes from authentication (originally 20120610164322)
class CreateUsers < ActiveRecord::Migration
  #
  def change
    create_table(:authentication_users) do |t|
      t.boolean(:system, :null => false, :default => false)
      t.string(:name, :null => false, :limit => 64)
      t.string(:email_address, :null => false, :limit => 128)
      t.string(:password_digest, :null => false, :limit => 64)
      t.string(:phone_number, :limit => 10)
      t.timestamps
    end
    add_index(:authentication_users, :name, :unique => true)
    add_index(:authentication_users, :email_address, :unique => true)
  end
end
