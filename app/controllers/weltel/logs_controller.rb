module Weltel
  class LogsController < SystemsController
    def show
      @filename = params[:id]
      @log = File.open(File.join(Rails.root, 'log', @filename), 'r').read
    end

    def destroy
      @filename = params[:id]
      File.open(File.join(Rails.root, 'log', @filename), 'w') {|f| f.write('') }
      flash[:notice] = t(".destroyed")
      redirect_to(weltel_system_path)
    end

	private
		#
		def t(key)
			I18n.t(key, :scope => [:weltel, :logs])
		end
	end
end
