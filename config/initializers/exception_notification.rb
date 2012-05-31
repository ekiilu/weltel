# -*- encoding : utf-8 -*-
if Rails.env.production?
	Weltel::Application.config.middleware.use ExceptionNotifier,
		:email_prefix => "[Weltel] ",
		:sender_address => %{"notifier" <site@verticallabs.ca>},
		:exception_recipients => %w{support@verticallabs.ca}
end



