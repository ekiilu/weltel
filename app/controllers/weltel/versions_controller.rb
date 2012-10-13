# -*- encoding : utf-8 -*-
module Weltel
  VERSION = '1.0.1'

	class VersionsController < SystemsController

		def show
			@update_in_progress = File.exists?("/www/weltel/shared/deploy")

      script = Rails.root.to_s + "/script/update_needed"
      output = `#{script}`
      raise output
      @update_needed = (output =~ /.*True*/)

      revision_file = File.join(Rails.root, 'REVISION')
      @revision = File.exist?(revision_file) ? File.open(revision_file).read : 'development'
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
			redirect_to(weltel_update_path)
		end
	end
end
