module Weltel
	class TasksController < ApplicationController
		#
		def send_reminders
			project = Project.get_active_by_name(Mambo.project)

			if project.state[LAST_SEND] == Date.today.cweek
				render(:text => "OK")
				return
			end

			# create service
			service = Weltel::Factory.new.service

			# send reminder
			service.send_reminders

			# update state
			project.state[LAST_SEND] = Date.today.cweek
			project.save

			render(:text => "OK")
		end

		#
		def receive_responses
			project = Project.get_active_by_name(Mambo.project)

			begin
				last_receive = project.state[LAST_RECEIVE]
				last_receive = last_receive.nil? ? DateTime.now : DateTime.parse(last_receive)

				# create service
				responder = Weltel::Factory.new.responder

				# send reminder
				responder.receive_responses(last_receive)

			ensure
				# update state
				project.state[LAST_RECEIVE] = DateTime.now
				project.save
			end

			render(:text => "OK")
		end

	private
		LAST_SEND = 'last_send'
		LAST_RECEIVE = 'last_receive'
	end
end
