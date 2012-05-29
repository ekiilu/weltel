module Weltel
	class Factory
		#
		def self.sender
			TwilioAdapter::SenderSync.new(AppConfig.twilio_phone_number)
		end

		#
		def self.poller
			TwilioAdapter::Poller.new(AppConfig.twilio_phone_number)
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
