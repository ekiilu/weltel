FactoryGirl.define do
	# default project
	factory(:project, :class => Project) do
		name('test')
		repo_name(:default.to_s)
	end

	# immunize project
	factory(:immunize_project, :class => Project) do
		name('immunize')
		repo_name(:default.to_s)
		factory_name(Immunize::Factory.to_s)
		state('phone_number' => '2222222222')
	end

	# weltel project
	factory(:weltel_project, :class => Project) do
		name('weltel')
		repo_name(:default.to_s)
		factory_name(Weltel::Factory.to_s)
		state('phone_number' => '3333333333')
	end
end