FactoryGirl.define do

  factory(:checkup, :class => Weltel::Checkup) do
  	patient
  	week 0
  	created_at { DateTime.now }
  	updated_at { DateTime.now }
  end
end
