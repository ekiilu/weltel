module Weltel
	class TasksController < ApplicationController
		#
		def reminders
			if DateTime.now.wday == 1 && DateTime.now.hour < 12
				render(:text => "OK")
				return
			end

			# send reminders
			service = Weltel::Factory.new.service.send_reminders

			render(:text => "OK")
		end

		#
		def responses
			# receive responses
			responder = Weltel::Factory.new.responder.receive_responses

			render(:text => "OK")
		end

	private
		SENDING = "sending"
		RECEIVING = "receiving"
	end
end
