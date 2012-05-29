FactoryGirl.define do
	#
	factory(:unknown_message, :class => Sms::Message) do
		phone_number "3333333333"
		status :Received
  	created_at { DateTime.now }
  	updated_at { DateTime.now }

		#
		factory(:message, :class => Sms::Message) do
			subscriber
		end

		#
		factory(:inactive_message, :class => Sms::Message) do
			#phone_number { subscriber.phone_number }
		end
	end
end
