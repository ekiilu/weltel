#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# This migration comes from authentication (originally 20120610164324)
class CreateRoles < ActiveRecord::Migration
  #
  def change
    create_table(:authentication_roles) do |t|
      t.boolean(:system, :null => false, :default => false)
      t.string(:name, :null => false, :limit => 64)
      t.string(:desc, :null => false, :limit => 64)
      t.timestamps
    end
    add_index(:authentication_roles, :name, :unique => true)
  end
end
