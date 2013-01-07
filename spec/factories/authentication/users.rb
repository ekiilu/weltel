#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
FactoryGirl.define do

	factory(:user, :class => Authentication::User) do
		system false
		sequence(:name) { |n| "name#{n}" }
		sequence(:email_address) { |n| "user#{n}@verticallabs.ca" }
		sequence(:password) { |n| "password#{n}" }
  	created_at { DateTime.now }
  	updated_at { DateTime.now }

		factory(:system) do
			system true
			email_address "system@verticallabs.ca"
		end
	end
end
