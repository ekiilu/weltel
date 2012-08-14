# This migration comes from sms (originally 20120610164322)
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

class CreateSubscribers < ActiveRecord::Migration
  #
  def change
    create_table(:sms_subscribers) do |t|
      t.boolean(:active, :null => false, :default => false)
      t.string(:phone_number, :null => false, :limit => Sms::PHONE_NUMBER_LENGTH)
      t.timestamps
    end

    add_index(:sms_subscribers, :active)
    add_index(:sms_subscribers, :phone_number, :unique => true)
  end
end
