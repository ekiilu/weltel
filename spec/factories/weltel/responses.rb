# -*- encoding : utf-8 -*-
FactoryGirl.define do
	#
  factory(:response, :class => Weltel::Response) do
  	sequence(:name) { |n| "name#{n}" }
  	created_at { DateTime.now }
  	updated_at { DateTime.now }
  end
end
