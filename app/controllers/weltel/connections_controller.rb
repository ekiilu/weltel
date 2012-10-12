module Weltel
  class ConnectionsController < SystemsController
    include Authentication::AuthenticatedController
    respond_to :html

    def destroy
      @connection = Connection.load_config(:current)
      connection_class = @connection.type.constantize
      connection_class.reset

      redirect_to(weltel_system_path)
    end

    def edit
      @connection = Connection.load_config(:current)
      @available_devices = Connection.available_devices 
    end

    def update
      params.select! {|k,v| Connection.valid_keys.include?(k.to_sym) }
      Connection.save_config(:current, params.merge({:type => Gammu::Connection.to_s}))
      @connection = Connection.load_config(:current)
      connection_class = @connection.type.constantize
      connection_class.reset

      redirect_to(weltel_system_path)
    end
  end
end
