# -*- encoding : utf-8 -*-
FactoryGirl.define do
	#
	factory(:subscriber, :class => Sms::Subscriber) do
		active true
		sequence(:phone_number) { |n| "604%07d" % n }
		created_at { DateTime.now }
  	updated_at { DateTime.now }
  	#patient_id { |subscriber| FactoryGirl.build(:patient, :subscriber_id => subscriber.id).id }

		#
  	factory(:inactive_subscriber) do
  		active false
  	end
	end
end
