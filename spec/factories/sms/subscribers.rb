#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
FactoryGirl.define do
	#
	factory(:subscriber, :class => Sms::Subscriber) do
		patient
		active true
		sequence(:phone_number) { |n| "604%07d" % n }
		created_at { DateTime.now }
  	updated_at { DateTime.now }

		#
  	factory(:inactive_subscriber) do
  		active false
  	end
	end
end
