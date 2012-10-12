#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

class CreateClinics < ActiveRecord::Migration
  def change
    create_table(:weltel_clinics) do |t|
      t.boolean(:system, :null => false, :default => false)
      t.string(:name, :null => false, :limit => 64)
      t.timestamps
    end

		add_index(:weltel_clinics, :system)
    add_index(:weltel_clinics, :name, :unique => true)
  end
end
