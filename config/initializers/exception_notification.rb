#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
if Rails.env.production?
	Weltel::Application.config.middleware.use ExceptionNotifier,
		:email_prefix => "[Weltel] ",
		:sender_address => %{"notifier" <site@verticallabs.ca>},
		:exception_recipients => %w{support@verticallabs.ca}
end



