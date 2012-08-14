# -*- encoding : utf-8 -*-
FactoryGirl.define do
	#
  factory(:clinic, :class => Weltel::Clinic) do
  	system { Support::Randomizer.boolean }
  	sequence(:name) { |n| "clinic#{n}" }
  	created_at { DateTime.now }
  	updated_at { DateTime.now }
  end
end
