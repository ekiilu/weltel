#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

class CreateConnectionConfigs < ActiveRecord::Migration
  def change
    create_table(:connection_configs) do |t|
      t.string(:device, :default => '/dev/ttyUSB0')
      t.text(:extra, :default => '')
      t.timestamps
    end
  end
end
