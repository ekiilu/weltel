FactoryGirl.define do

  factory(:record, :class => Weltel::Record) do |r|
  	created_on { Date.today }
  	created_at { DateTime.now }
  	updated_at { DateTime.now }
  	r.patient { |r| FactoryGirl.build(:patient) }
  end
end
