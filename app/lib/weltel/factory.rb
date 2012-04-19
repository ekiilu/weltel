module Weltel
	class Factory
		#
		def sender
			TwilioSenderSync.new(Mambo.phone_number)
		end

		#
		def poller
			TwilioPoller.new(Mambo.phone_number)
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
