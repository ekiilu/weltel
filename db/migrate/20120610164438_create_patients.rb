class CreatePatients < ActiveRecord::Migration
  def change
    create_table(:weltel_patients) do |t|
    	t.references(:clinic)
      t.boolean(:active, :null => false, :default => true)
      t.string(:user_name, :null => false, :limit => 32)
      t.string(:study_number, :null => false, :limit => 32)
      t.string(:contact_phone_number, :length => 10)
      t.timestamps
    end

		add_index(:weltel_patients, :clinic_id)
    add_index(:weltel_patients, :user_name, :unique => true)
    add_index(:weltel_patients, :study_number, :unique => true)
  end
end
