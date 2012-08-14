# -*- encoding : utf-8 -*-
FactoryGirl.define do

	factory(:user, :class => Authentication::User) do
		system false
		sequence(:name) { |n| "name#{n}" }
		sequence(:email_address) { |n| "user#{n}@verticallabs.ca" }
		sequence(:password) { |n| "password#{n}" }
  	created_at { DateTime.now }
  	updated_at { DateTime.now }

		factory(:system) do
			system true
		end
	end
end
