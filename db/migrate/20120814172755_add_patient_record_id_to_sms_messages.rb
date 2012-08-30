class AddPatientRecordIdToSmsMessages < ActiveRecord::Migration
	def change
		add_column :sms_messages, :patient_record_id, :integer
		add_index :sms_messages, :patient_record_id
  end
end
