FactoryGirl.define do
	#
	factory(:subscriber, :class => Sms::Subscriber) do
		patient
		phone_number "2222222222"
		active 1
  	created_at { DateTime.now }
  	updated_at { DateTime.now }

  	factory(:inactive_subscriber, :class => Sms::Subscriber) do
  		active 0
  	end
	end
end
