# -*- encoding : utf-8 -*-
FactoryGirl.define do

	factory(:system, :class => Authentication::User) do
		system true
		name "system"
		email_address "system@verticallabs.ca"
  	created_at { DateTime.now }
  	updated_at { DateTime.now }
	end
end
