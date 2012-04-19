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
	:name => "administrator"
)

Authorization::UserRole.create(
	:user => system,
	:role => admin,
)

Sms::MessageTemplate.create(
	:name => "Positive Response",
	:body => "Great. I will text you next week"
)

Sms::MessageTemplate.create(
	:name => "Negative Response",
	:body => "Okay. I will call you soon"
)

Sms::MessageTemplate.create(
	:name => "No Response",
	:body => "Haven't heard from you... how's it going?"
)

Sms::MessageTemplate.create(
	:name => "First Missed Call",
	:body => "Got your text, tried calling, how are things?"
)

Sms::MessageTemplate.create(
	:name => "Second Missed Call",
	:body => "Got your text, tried calling again, how are things?"
)