class AddPatientRecordIdToSmsMessages < ActiveRecord::Migration
	def up
		add_column :sms_messages, :patient_record_id, :integer
		add_index :sms_messages, :patient_record_id
  end

  def down
  	rem_index :sms_messages, :patient_record_id
    remove_column :sms_messages, :patient_record_id
  end
end
