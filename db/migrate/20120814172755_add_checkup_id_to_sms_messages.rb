#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

class AddCheckupIdToSmsMessages < ActiveRecord::Migration
	def change
		add_column :sms_messages, :checkup_id, :integer
		add_index :sms_messages, :checkup_id
  end
end
