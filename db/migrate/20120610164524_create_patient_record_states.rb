class CreatePatientRecordStates < ActiveRecord::Migration
  def change
    create_table(:weltel_patient_record_states) do |t|
      t.boolean(:active, :null => false, :default => true)
      t.string(:value, :null => false)
      t.datetime(:created_at, :null => false)
    end

    add_index(:weltel_patient_record_states, :active)
  end
end
