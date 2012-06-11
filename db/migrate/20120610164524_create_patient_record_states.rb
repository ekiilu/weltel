class CreatePatientRecordStates < ActiveRecord::Migration
  def change
    create_table(:patient_record_states) do |t|
      t.boolean(:active, :null => false, :default => true)
      t.integer(:value, :null => false, :default => 0)
      t.datetime(:created_at)
    end
  end
end

    # properties
    #property(:id, Serial)
    #property(:active, Boolean, {:index => true, :required => true, :default => true})
    #property(:value, Enum[*VALUES], {:index => true, :required => true, :default => :unknown})
    #property(:created_at, DateTime)
