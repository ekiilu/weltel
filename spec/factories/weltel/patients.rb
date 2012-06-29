# -*- encoding : utf-8 -*-
FactoryGirl.define do
	#
	sequence(:user_name) do |n|
		"user_name#{n}"
	end

	#
	sequence(:study_number) do |n|
		"study_number#{n}"
	end

	#
  factory(:patient, :class => Weltel::Patient) do
  	clinic
  	user_name FactoryGirl.generate(:user_name)
  	study_number FactoryGirl.generate(:study_number)
  	created_at { DateTime.now }
  	updated_at { DateTime.now }
  	subscriber_id { FactoryGirl.create(:subscriber).id }

  	#p.records { |p| [FactoryGirl.build(:record, :patient => p)] }
  end
end
