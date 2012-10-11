#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
FactoryGirl.define do

  factory(:patient_record, :class => Weltel::PatientRecord) do
  	patient
  	contact_method { Support::Randomizer.array(Weltel::PatientRecord::CONTACT_METHODS) }
  	created_on { Date.today }
  	created_at { DateTime.now }
  	updated_at { DateTime.now }

  	factory(:patient_record_with_state) do
			ignore do
        state :unknown
      end

			after(:create) do |record, evaluator|
        FactoryGirl.create_list(:patient_record_state, 1, :record => record, :value => evaluator.state)
      end
  	end
  end
end
