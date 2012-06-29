class CreatePatients < ActiveRecord::Migration
  def change
    create_table(:weltel_patients) do |t|
    	t.references(:subscriber, :null => false)
    	t.references(:clinic, :null => false)
      t.boolean(:system, :null => false, :default => false)
      t.string(:user_name, :null => false, :limit => 32)
      t.string(:study_number, :null => false, :limit => 32)
      t.string(:contact_phone_number, :length => 10)
      t.timestamps
    end

		add_index(:weltel_patients, :subscriber_id)
		add_index(:weltel_patients, :clinic_id)
    add_index(:weltel_patients, :user_name, :unique => true)
    add_index(:weltel_patients, :study_number, :unique => true)
  end
end
