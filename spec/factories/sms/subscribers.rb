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
