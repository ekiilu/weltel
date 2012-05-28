FactoryGirl.define do

	factory(:subscriber, :class => Sms::Subscriber) do
		phone_number "2222222222"
		active 1
  	created_at { DateTime.now }
  	updated_at { DateTime.now }
	end
end
