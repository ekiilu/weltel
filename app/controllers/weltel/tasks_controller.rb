module Weltel
	class TasksController < ApplicationController
		#
		def reminders
			if DateTime.now.wday == 1 && DateTime.now.hour < 12
				render(:text => "OK")
				return
			end

			project = Project.get_active_by_name(CONFIG[:project])

			if project.state[SENDING] == true
				render(:text => "OK")
				return
			end

			begin
				project.state[SENDING] = true
				project.save

				# send reminders
				service = Weltel::Factory.new.service.send_reminders

				render(:text => "OK")

			ensure
				# update project
				project.state[SENDING] = false
				project.save
			end
		end

		#
		def responses
			project = Project.get_active_by_name(CONFIG[:project])

			if project.state[RECEIVING] == true
				render(:text => "OK")
				return
			end

			begin
				project.state[RECEIVING] = true
				project.save

				# receive responses
				responder = Weltel::Factory.new.responder.receive_responses

				render(:text => "OK")

			ensure
				# update project
				project.state[RECEIVING] = false
				project.save
			end
		end

	private
		SENDING = "sending"
		RECEIVING = "receiving"
	end
end
