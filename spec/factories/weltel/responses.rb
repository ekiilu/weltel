FactoryGirl.define do
	#
  factory(:response, :class => Weltel::Command) do |c|
  	c.created_at { DateTime.now }
  	c.updated_at { DateTime.now }
  end
end
