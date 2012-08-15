# -*- encoding : utf-8 -*-
FactoryGirl.define do
	#
	sequence(:phone_number) do |n|
    "604%07d" % n
  end

	#
	factory(:subscriber, :class => Sms::Subscriber) do
		active 1
		phone_number FactoryGirl.generate(:phone_number)
		created_at { DateTime.now }
  	updated_at { DateTime.now }
  	patient { |subscriber| FactoryGirl.build(:patient, :subscriber => subscriber) }

		#
  	factory(:inactive_subscriber) do
  		active 0
  	end
	end
end
