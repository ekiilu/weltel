# -*- encoding : utf-8 -*-
FactoryGirl.define do
	#
	factory(:unknown_message, :class => Sms::Message) do
		phone_number "3333333333"
		status :Received
  	created_at { DateTime.now }
  	updated_at { DateTime.now }

		#
  	factory(:subscriber_message) do
  		phone_number "2222222222"

			#
			factory(:active_message) do
				subscriber
			end

			#
			factory(:inactive_message) do
				association :subscriber, :factory => :inactive_subscriber
			end
  	end
	end
end
