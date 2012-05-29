FactoryGirl.define do
	#
  factory(:patient, :class => Weltel::Patient) do |p|
  	p.username "username"
  	p.study_number "study_number"
  	p.created_at { DateTime.now }
  	p.updated_at { DateTime.now }
  	p.subscriber { |p| FactoryGirl.build(:subscriber, :patient => p) }
  	p.records { |p| [FactoryGirl.build(:record, :patient => p)] }
  end
end
