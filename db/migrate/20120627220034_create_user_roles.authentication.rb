# This migration comes from authentication (originally 20120610164323)
class CreateUserRoles < ActiveRecord::Migration
  #
  def change
    create_table(:authentication_user_roles) do |t|
      t.references(:user, :null => false)
      t.references(:role, :null => false)
      t.timestamps
    end
    add_index(:authentication_user_roles, [:user_id, :role_id], :unique => true)
  end
end
