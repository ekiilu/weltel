# -*- encoding : utf-8 -*-
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
					association :subscriber, :factory => :inactive_subscriber
				end
			end
		end
	end
end
