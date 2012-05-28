module Weltel
	class Factory
		#
		def self.sender
			TwilioAdapter::SenderSync.new(CONFIG[:twilio_phone_number])
		end

		#
		def self.poller
			TwilioAdapter::Poller.new(CONFIG[:twilio_phone_number])
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
