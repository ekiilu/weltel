#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Weltel
	class Factory
		#
		def self.sender
			Adapters::Twilio::Sender.new(AppConfig.twilio.phone_number)
		end

		#
		def self.poller
			Adapters::Twilio::Poller.new(AppConfig.twilio.phone_number)
		end

		#
		def self.responder
			Weltel::Responder.new(sender, poller, alerter)
		end

		#
		def self.service
			Weltel::Service.new(sender)
		end

		#
		def self.alerter
			Weltel::Alerter.new(sender)
		end
	end
end
