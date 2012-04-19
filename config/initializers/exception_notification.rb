if Rails.env.production?
	Weltel::Application.config.middleware.use ExceptionNotifier,
		:email_prefix => "[Weltel] ",
		:sender_address => %{"notifier" <site@verticallabs.ca>},
		:exception_recipients => %w{chris@verticallabs.ca}
end