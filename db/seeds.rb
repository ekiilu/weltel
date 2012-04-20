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

	admin = Authorization::Role.create(
		:name => :administrator.to_s,
		:desc => "Administrator"
	)

	Authorization::UserRole.create(
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
		:type => :system
	)

	Sms::MessageTemplate.create(
		:name => :help.to_s,
		:desc => "Help Reply",
		:body => "Please contact the administrator at 778-858-0004",
		:type => :system
	)

	Sms::MessageTemplate.create(
		:name => :stop.to_s,
		:desc => "Stop Reply",
		:body => "You will not receive more messages from this number. Reply START to start",
		:type => :system
	)

	Sms::MessageTemplate.create(
		:name => :start.to_s,
		:desc => "Start Reply",
		:body => "You will now receive messages again.  Reply STOP to stop",
		:type => :system
	)

	Sms::MessageTemplate.create(
		:name => :unknown.to_s,
		:desc => "Unknown Patient Reply",
		:body => "Your number is not recognized. Please contact the administrator at 778-858-0004",
		:type => :system
	)

	Sms::MessageTemplate.create(
		:name => :inactive.to_s,
		:desc => "Inactive Patient Reply",
		:body => "You are no longer registered. Please contact the administrator at 778-858-0004",
		:type => :system
	)

rescue DataMapper::SaveFailureError => error
	Rails.logger.error(error.resource.errors.inspect)
	raise error
end