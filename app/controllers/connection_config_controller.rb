#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

class ConnectionConfigController < ActionController::Base
  include Authentication::AuthenticatedController
  layout 'private/application'
  respond_to :html

  def edit
    @connection_config = ConnectionConfig.first
    @available_devices = ConnectionConfig.available_devices 
  end

  def update
    @connection_config = ConnectionConfig.first
    @connection_config.update_attributes!(params[:connection_config])
    redirect_to(weltel_update_path)
  end

  def test
    @connection_config = ConnectionConfig.first
  end

  def send_test
    if ConnectionConfig.send_test(params[:phone_number], params[:message])
      flash[:notice] = t('.connection_config.test.sent')
    else
      flash[:notice] = t('.connection_config.test.failed')
    end
    redirect_to(weltel_update_path)
  end
end