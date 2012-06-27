class CreateClinics < ActiveRecord::Migration
  def change
    create_table(:weltel_clinics) do |t|
      t.boolean(:system, :null => false, :default => false)
      t.string(:name, :null => false, :limit => 64)
      t.timestamps
    end

		add_index(:weltel_clinics, :system)
    add_index(:weltel_clinics, :name, :unique => true)
  end
end
