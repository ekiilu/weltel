begin
	Weltel::Project.create(
		:name => "ltbi",
		:state => {
			:last_receive => DateTime.now
		}
	)

	Weltel::Project.create(
		:name => "hiv",
		:state => {
			:last_receive => DateTime.now
		}
	)

	system = Authentication::User.create(
		:name => "System",
		:email_address => "system@verticallabs.ca",
		:password => "weltel",
		:password_confirmation => "weltel",
	)

	admin = Authentication::Role.create(
		:name => :administrator.to_s,
		:desc => "Administrator"
	)

	Authentication::Role.create(
		:name => :clinician.to_s,
		:desc => "Clinician"
	)

	Authentication::UserRole.create(
		:user => system,
		:role => admin,
	)

	Sms::MessageTemplate.create(
		:desc => "Positive Response",
		:body => "Great. I will text you next week"
	)

	Sms::MessageTemplate.create(
		:desc => "Negative Response",
		:body => "Okay. I will call you soon"
	)

	Sms::MessageTemplate.create(
		:desc => "No Response",
		:body => "Haven't heard from you... how's it going?"
	)

	Sms::MessageTemplate.create(
		:desc => "First Missed Call",
		:body => "Got your text, tried calling, how are things?"
	)

	Sms::MessageTemplate.create(
		:desc => "Second Missed Call",
		:body => "Got your text, tried calling again, how are things?"
	)

	Sms::MessageTemplate.create(
		:name => :reminder.to_s,
		:desc => "Weekly Reminder",
		:body => "Are you ok?",
		:type => :System
	)

	Sms::MessageTemplate.create(
		:name => :help.to_s,
		:desc => "Help Reply",
		:body => "Please contact the administrator at 778-858-0004",
		:type => :System
	)

	Sms::MessageTemplate.create(
		:name => :stop.to_s,
		:desc => "Stop Reply",
		:body => "You will not receive more messages from this number. Reply START to start",
		:type => :System
	)

	Sms::MessageTemplate.create(
		:name => :start.to_s,
		:desc => "Start Reply",
		:body => "You will now receive messages again.  Reply STOP to stop",
		:type => :System
	)

	Sms::MessageTemplate.create(
		:name => :unknown.to_s,
		:desc => "Unknown Patient Reply",
		:body => "Your number is not recognized. Please contact the administrator at 778-858-0004",
		:type => :System
	)

	Sms::MessageTemplate.create(
		:name => :inactive.to_s,
		:desc => "Inactive Patient Reply",
		:body => "You are no longer registered. Please contact the administrator at 778-858-0004",
		:type => :System
	)

	50.times do |p|
		subscriber = Sms::Subscriber.create(
			:phone_number => "60470000%02d" % p,
			:active => true
		)

		Weltel::Patient.create(
			:subscriber => subscriber,
			:username => "patient%02d" % p,
			:study_number => "number%02d" % p,
			:state => :ok,
			:week => 0,
		)
	end

rescue DataMapper::SaveFailureError => error
	Rails.logger.error(error.resource.errors.inspect)
	raise error
end