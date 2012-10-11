#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

class CreateCheckups < ActiveRecord::Migration
  def change
    create_table(:weltel_checkups) do |t|
    	t.references(:patient, :null => false)
      t.boolean(:current, :null => false, :default => true)
      t.date(:created_on, :null => false)
      t.enum(:status, :null => false)
      t.enum(:contact_method, :null => false)
      t.timestamps
    end

		add_index(:weltel_checkups, :patient_id)
    add_index(:weltel_checkups, :current)
    add_index(:weltel_checkups, :created_on)
  end
end
