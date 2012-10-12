#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

FactoryGirl.define do

  factory(:checkup, :class => Weltel::Checkup) do
  	patient
  	contact_method { Support::Randomizer.array(Weltel::Checkup::CONTACT_METHODS) }
  	current true
  	created_on { Date.today }
  	created_at { DateTime.now }
  	updated_at { DateTime.now }

		#
  	factory(:checkup_with_result) do
			ignore do
        state :unknown
      end

			after(:create) do |checkup, evaluator|
        checkup.results = create_list(:result, 1, :checkup => checkup, :value => evaluator.state)
      end
  	end
  end
end
