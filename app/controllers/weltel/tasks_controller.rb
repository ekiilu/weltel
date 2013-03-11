#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Weltel
	class TasksController < ApplicationController
		respond_to(:html, :js)

		#
		def create_checkups
			# send reminders
			date = Date.today.monday
			if Weltel::Factory.service.create_checkups(date)
				render(:text => "OK")
			else
				render(:text => "FAIL", :status => 404)
			end
		end

		#
		def update_checkups
			if Weltel::Factory.service.update_checkups
				render(:text => "OK")
			else
				render(:text => "FAIL", :status => 404)
			end
		end

		#
		def receive_responses
			# receive responses
			Weltel::Factory.responder.receive_responses
			render(:text => "OK")
		end
	end
end
