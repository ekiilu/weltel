module Weltel
  class LogsController < SystemsController
    def index
      @logs = Dir.glob(File.join(Rails.root, 'log', '*.log')).map {|f| File.basename(f)}
    end

    def show
      @filename = params[:id]
      @log = File.open(File.join(Rails.root, 'log', @filename), 'r').read
    end

    def destroy
      @filename = params[:id]
      File.open(File.join(Rails.root, 'log', @filename), 'w') {|f| f.write('') }
      redirect_to(weltel_system_logs_path)
    end
  end
end
