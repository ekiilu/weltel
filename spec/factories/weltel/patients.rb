FactoryGirl.define do

  factory(:patient, :class => Weltel::Patient) do
  	subscriber
  	username "username"
  	study_number "study_number"
  	created_at { DateTime.now }
  	updated_at { DateTime.now }
  end
end
