module Weltel
	class Factory
		#
		def sender
			TwilioAdapter::SenderSync.new(TWILIO_PHONE_NUMBER)
		end

		#
		def poller
			TwilioAdapter::Poller.new(TWILIO_PHONE_NUMBER)
		end

		#
		def responder
			Weltel::Responder.new(sender, poller, alerter)
		end

		#
		def service
			Weltel::Service.new(sender)
		end

		#
		def alerter
			Weltel::Alerter.new(sender)
		end
	end
end
