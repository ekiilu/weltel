# -*- encoding : utf-8 -*-
module Weltel
	class UpdatesController < ApplicationController
		include Authentication::AuthenticatedController
		layout("private/application")

		#
		def show
			script = Rails.root.to_s + "/script/update_needed"
			output = `#{script}`
			@update_needed = output =~ /.*Update needed.*/
		end

		#
		def update
			script = Rails.root.to_s + "/script/update"
			out = Rails.root.to_s + "/tmp/update_out"
			err = Rails.root.to_s + "/tmp/update_err"
			pid = Kernel.spawn(script, {:out => out, :err => err})
			Process.detach(pid)
			logger.error(pid)
			FileUtils.touch("/www/weltel/shared/deploy")
			redirect_to(status_weltel_update_path)
		end

		#
		def status
			@update_complete = !File.exists?("/www/weltel/shared/deploy")
		end
	end
end
