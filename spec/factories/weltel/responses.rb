# -*- encoding : utf-8 -*-
FactoryGirl.define do
	#
  factory(:response, :class => Weltel::Response) do |c|
  	c.created_at { DateTime.now }
  	c.updated_at { DateTime.now }
  end
end
