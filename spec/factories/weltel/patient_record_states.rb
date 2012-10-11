#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
FactoryGirl.define do

  factory(:patient_record_state, :class => Weltel::PatientRecordState) do
  	record { FactoryGirl.create(:patient_record) }
  	user
  	active true
  	value :positive
  	created_at { DateTime.now }
	end
end
