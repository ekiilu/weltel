module Weltel
	class TasksController < ApplicationController
		#
		def reminders
			project = Project.get_active_by_name(CONFIG[:project])

			if project.state[LAST_SEND] == Date.today.cweek
				render(:text => "OK")
				return
			end

			begin
				# send reminders
				service = Weltel::Factory.new.service.send_reminders

				render(:text => "OK")

			ensure
				# update project
				project.state[LAST_SEND] = Date.today.cweek
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
				responder = Weltel::Factory.new.responder.receive_responses(
					DateTime.parse(project.state[LAST_RECEIVE])
				)

				render(:text => "OK")

			ensure
				# update project
				project.state[RECEIVING] = false
				project.state[LAST_RECEIVE] = DateTime.now
				project.save
			end
		end

	private
		LAST_SEND = "last_send"
		RECEIVING = "receiving"
		LAST_RECEIVE = "last_receive"
	end
end
