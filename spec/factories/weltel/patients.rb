#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
FactoryGirl.define do
	#
  factory(:patient, :class => Weltel::Patient) do
  	clinic
  	active true
  	sequence(:user_name) { |n| "user_name#{n}" }
  	sequence(:study_number) { |n| "study_number#{n}" }
  	created_at { DateTime.now }
  	updated_at { DateTime.now }

  	after(:create) do |patient|
  		patient.subscriber = create(:subscriber, :patient => patient)
  	end

		#
  	factory(:patient_with_current_checkup) do
			after(:create) do |patient, evaluator|
        patient.checkups = create_list(:checkup, 1, :patient => patient, :current => true)
      end
  	end
  end
end
