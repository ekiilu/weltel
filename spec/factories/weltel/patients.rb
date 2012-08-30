# -*- encoding : utf-8 -*-
FactoryGirl.define do
	#
  factory(:patient, :class => Weltel::Patient) do
  	clinic
  	active true
  	sequence(:user_name) { |n| "user_name#{n}" }
  	sequence(:study_number) { |n| "study_number#{n}" }
  	created_at { DateTime.now }
  	updated_at { DateTime.now }

  	after(:create) do |patient|
  		patient.subscriber = create(:subscriber, :patient => patient)
  	end
  end
end
