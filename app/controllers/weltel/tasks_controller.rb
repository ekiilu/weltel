module Weltel
	class TasksController < ApplicationController
		#
		def reminders
			project = Project.get_active_by_name(Settings.project)

			if project.state[LAST_SEND] == Date.today.cweek
				render(:text => "OK")
				return
			end

			# send reminders
			service = Weltel::Factory.new.service.send_reminders

			# update project
			project.state[LAST_SEND] = Date.today.cweek
			project.save

			render(:text => "OK")
		end

		#
		def responses
			project = Project.get_active_by_name(Settings.project)

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

			ensure
				# update project
				project.state[RECEIVING] = false
				project.state[LAST_RECEIVE] = DateTime.now
				project.save
			end

			render(:text => "OK")
		end

	private
		LAST_SEND = "last_send"
		RECEIVING = "receiving"
		LAST_RECEIVE = "last_receive"
	end
end
