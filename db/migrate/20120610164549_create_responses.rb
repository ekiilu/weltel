#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

class CreateResponses < ActiveRecord::Migration
  def change
    create_table(:weltel_responses) do |t|
      t.string(:name, :null => false, :limit => 160)
      t.string(:value, :null => false)
      t.timestamps
    end

    add_index(:weltel_responses, :name, :unique => true)
  end
end
