module Weltel
  class TestsController < SystemsController
    respond_to :html

    def new
      @connection = Weltel::Connection.load_config(:current)
    end

    def create
      @connection = Weltel::Connection.load_config(:current)
      connection_class = @connection.type.constantize
      connection_class.reset
      if connection_class.send_sms(params[:phone_number], params[:message])
        flash[:notice] = t('.weltel.tests.sent')
      else
        flash[:notice] = t('.weltel.tests.failed')
      end
      redirect_to(weltel_system_path)
    end
  end
end
