class AddPatientIdToSmsSubscribers < ActiveRecord::Migration
	def change
		add_column :sms_subscribers, :patient_id, :integer, :null => false
		add_index :sms_subscribers, :patient_id
  end
end
