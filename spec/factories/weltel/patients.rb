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
  	subscriber_id { FactoryGirl.create(:subscriber).id }
  end
end
