# -*- encoding : utf-8 -*-
FactoryGirl.define do

  factory(:record, :class => Weltel::Record) do
  	patient
  	created_on { Date.today }
  	created_at { DateTime.now }
  	updated_at { DateTime.now }
  end
end
