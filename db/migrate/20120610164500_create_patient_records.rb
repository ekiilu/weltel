class CreatePatientRecords < ActiveRecord::Migration
  def change
    create_table(:weltel_patient_records) do |t|
    	t.references(:patient, :null => false)
      t.boolean(:active, :null => false, :default => true)
      t.date(:created_on, :null => false)
      t.string(:status, :null => false)
      t.string(:contact_method, :null => false)
      t.timestamps
    end

		add_index(:weltel_patient_records, :patient_id)
    add_index(:weltel_patient_records, :active)
    add_index(:weltel_patient_records, :created_on)
  end
end
