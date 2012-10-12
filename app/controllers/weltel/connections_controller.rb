module Weltel
  class ConnectionsController < SystemsController
    include Authentication::AuthenticatedController
    respond_to :html

		#
    def edit
      @connection = Adapters::Connection.load_config(:current)
      @available_devices = Adapters::Connection.available_devices
    end

		#
    def update
      params.select! {|k,v| Adapters::Connection.valid_keys.include?(k.to_sym) }
      Adapters::Connection.save_config(:current, params.merge({:type => Adapters::Gammu::Connection.to_s}))
      @connection = Adapters::Connection.load_config(:current)

      if @connection.type
				connection_class = @connection.type.constantize
				connection_class.reset
			end

      flash[:notice] = t(:updated)

      redirect_to(weltel_system_path)
    end

		#
    def destroy
      @connection = Adapters::Connection.load_config(:current)

      if @connection.type
				connection_class = @connection.type.constantize
				connection_class.reset
      end

      flash[:notice] = t(:destroyed)

      redirect_to(weltel_system_path)
    end

	private
		#
		def t(key)
			I18n.t(key, :scope => [:weltel, :connections])
		end
	end
end
