module Weltel
	class Factory
		#
		def sender
			TwilioAdapter::SenderSync.new(CONFIG[:twilio_phone_number])
		end

		#
		def poller
			TwilioAdapter::Poller.new(CONFIG[:twilio_phone_number])
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
