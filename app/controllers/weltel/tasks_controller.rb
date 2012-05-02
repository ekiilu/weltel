module Weltel
	class TasksController < ApplicationController
		#
		def reminders
			if DateTime.now.wday == 1 && DateTime.now.hour < 12
				render(:text => "OK")
				return
			end

			project = Project.get_active_by_name(CONFIG[:project])

			# send reminders
			service = Weltel::Factory.new.service.send_reminders

			render(:text => "OK")
		end

		#
		def responses
			project = Project.get_active_by_name(CONFIG[:project])

			# receive responses
			responder = Weltel::Factory.new.responder.receive_responses

			render(:text => "OK")
		end

	private
		SENDING = "sending"
		RECEIVING = "receiving"
	end
end
