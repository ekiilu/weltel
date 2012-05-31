# -*- encoding : utf-8 -*-
FactoryGirl.define do
	#
	sequence(:user_name) do |n|
		"username#{n}"
	end

	#
	sequence(:study_number) do |n|
		"studynumber#{n}"
	end

	#
  factory(:patient, :class => Weltel::Patient) do
  	username FactoryGirl.generate(:user_name)
  	study_number FactoryGirl.generate(:study_number)
  	created_at { DateTime.now }
  	updated_at { DateTime.now }
  	subscriber { |patient| FactoryGirl.build(:subscriber, :patient => patient) }

  	#p.records { |p| [FactoryGirl.build(:record, :patient => p)] }
  end
end
