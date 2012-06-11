class CreateClinics < ActiveRecord::Migration
  def change
    create_table(:clinics) do |t|
      t.boolean(:system, :null => false, :default => false)
      t.string(:name, :null => false, :limit => 64)
      t.timestamps
    end
  end
  add_index(:clinics, :name, :unique => true)
end
