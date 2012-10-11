#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# This migration comes from sms (originally 20120627221621)
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

class CreateMessages < ActiveRecord::Migration
  #
  def change
    create_table(:sms_messages) do |t|
    	t.references(:subscriber)
    	t.references(:parent)
    	t.enum(:status, :null => false)
      t.string(:phone_number, {:null => false, :limit => Sms::PHONE_NUMBER_LENGTH})
      t.string(:body, :limit => Sms::MESSAGE_BODY_MAX)
      t.string(:sid, :limit => Sms::MESSAGE_SID_LENGTH)
      t.timestamps
    end

		add_index(:sms_messages, :subscriber_id)
		add_index(:sms_messages, :parent_id)
    add_index(:sms_messages, :status)
    add_index(:sms_messages, :phone_number)
    add_index(:sms_messages, :sid)
  end
end
