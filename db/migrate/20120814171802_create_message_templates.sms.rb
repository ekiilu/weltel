#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# This migration comes from sms (originally 20120627221622)
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

class CreateMessageTemplates < ActiveRecord::Migration
  #
  def change
    create_table(:sms_message_templates) do |t|
    	t.boolean(:system, :null => false, :default => false)
      t.string(:name, :limit => Sms::MESSAGE_TEMPLATE_NAME_MAX)
      t.string(:desc, :null => false, :limit => Sms::MESSAGE_TEMPLATE_DESC_MAX)
      t.string(:body, :null => false, :limit => Sms::MESSAGE_TEMPLATE_BODY_MAX)
      t.timestamps
    end

    add_index(:sms_message_templates, :system)
    add_index(:sms_message_templates, :name, :unique => true)
    add_index(:sms_message_templates, :desc, :unique => true)
  end
end
