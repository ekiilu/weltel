FactoryGirl.define do

	factory(:subscriber, :class => Sms::Subscriber) do |s|
		s.active 1
		s.phone_number "2222222222"
		s.created_at { DateTime.now }
  	s.updated_at { DateTime.now }
  	s.patient { |a| FactoryGirl.build(:patient, :subscriber => a) }

		#
  	factory(:inactive_subscriber) do |s|
  		s.active 0
  	end
	end
end
