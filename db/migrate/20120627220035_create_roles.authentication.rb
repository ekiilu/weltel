# This migration comes from authentication (originally 20120610164324)
class CreateRoles < ActiveRecord::Migration
  #
  def change
    create_table(:authentication_roles) do |t|
      t.boolean(:system, :null => false, :default => false)
      t.string(:name, :null => false, :limit => 64)
      t.string(:desc, :null => false, :limit => 64)
      t.timestamps
    end
    add_index(:authentication_roles, :name, :unique => true)
  end
end
