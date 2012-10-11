#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

class AddPatientIdToSmsSubscribers < ActiveRecord::Migration
	def change
		add_column :sms_subscribers, :patient_id, :integer, :null => false
		add_index :sms_subscribers, :patient_id
  end
end
