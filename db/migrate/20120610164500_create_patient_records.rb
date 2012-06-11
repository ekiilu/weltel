class CreatePatientRecords < ActiveRecord::Migration
  def change
    create_table(:patient_records) do |t|
      t.boolean(:active, :null => false, :default => true)
      t.date(:created_on, :null => false)
      #property(:status, Enum[*STATUSES], {:index => true, :required => true, :default => :open})
      #property(:contact_method, Enum[*CONTACT_METHODS], {:index => true, :required => true, :default => :none})
      t.timestamps
    end
  end
end
