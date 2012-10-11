#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# This migration comes from authentication (originally 20120610164323)
class CreateUserRoles < ActiveRecord::Migration
  #
  def change
    create_table(:authentication_user_roles) do |t|
      t.references(:user, :null => false)
      t.references(:role, :null => false)
      t.timestamps
    end
    add_index(:authentication_user_roles, [:user_id, :role_id], :unique => true)
  end
end
