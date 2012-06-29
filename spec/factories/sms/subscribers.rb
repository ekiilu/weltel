# -*- encoding : utf-8 -*-
FactoryGirl.define do
	#
	sequence(:phone_number) do |n|
    "604%07d" % n
  end

	#
	factory(:subscriber, :class => Sms::Subscriber) do
		active true
		phone_number FactoryGirl.generate(:phone_number)
		created_at { DateTime.now }
  	updated_at { DateTime.now }
  	#patient_id { |subscriber| FactoryGirl.build(:patient, :subscriber_id => subscriber.id).id }

		#
  	factory(:inactive_subscriber) do
  		active false
  	end
	end
end
