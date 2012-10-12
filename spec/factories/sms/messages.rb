#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

FactoryGirl.define do

	factory(:message, :class => Sms::Message) do
		phone_number "3333333333"
		status :unknown
		created_at { DateTime.now }
		updated_at { DateTime.now }

		#
		factory(:unknown_message) do
			#
			factory(:subscriber_message) do
				phone_number "2222222222"

				#
				factory(:active_message) do
					subscriber
				end

				#
				factory(:inactive_message) do
					subscriber { create(:inactive_subscriber) }
				end
			end
		end
	end
end
