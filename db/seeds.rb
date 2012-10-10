# -*- encoding : utf-8 -*-
system = Authentication::User.create(
	:system => true,
	:name => "System",
	:email_address => "system@verticallabs.ca",
	:password => "weltel",
	:password_confirmation => "weltel",
)

admin = Authentication::Role.create(
	:system => true,
	:name => :administrator.to_s,
	:desc => "Administrator"
)

Authentication::Role.create(
	:system => true,
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
	:name => :checkup.to_s,
	:desc => "Weekly Checkup",
	:body => "Are you ok?",
	:system => true
)

Sms::MessageTemplate.create(
	:name => :help.to_s,
	:desc => "Help Reply",
	:body => "Please contact the administrator at 778-858-0004",
	:system => true
)

Sms::MessageTemplate.create(
	:name => :stop.to_s,
	:desc => "Stop Reply",
	:body => "You will not receive more messages from this number. Reply START to start",
	:system => true
)

Sms::MessageTemplate.create(
	:name => :start.to_s,
	:desc => "Start Reply",
	:body => "You will now receive messages again.  Reply STOP to stop",
	:system => true
)

Sms::MessageTemplate.create(
	:name => :unknown.to_s,
	:desc => "Unknown Patient Reply",
	:body => "Your number is not recognized. Please contact the administrator at 778-858-0004",
	:system => true
)

Sms::MessageTemplate.create(
	:name => :inactive.to_s,
	:desc => "Inactive Patient Reply",
	:body => "You are no longer registered. Please contact the administrator at 778-858-0004",
	:system => true
)

Weltel::Clinic.create(
	:name => "BCCDC"
)

Weltel::Response.create(
	:name => "yes",
	:value => :positive
)

Weltel::Response.create(
	:name => "no",
	:value => :negative
)

Weltel::Connection.create(
  :device => '/dev/ttyUSB0',
  :extra => ''
)
