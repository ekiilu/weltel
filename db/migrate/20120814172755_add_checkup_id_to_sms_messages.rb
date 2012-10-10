class AddCheckupIdToSmsMessages < ActiveRecord::Migration
	def change
		add_column :sms_messages, :checkup_id, :integer
		add_index :sms_messages, :checkup_id
  end
end
