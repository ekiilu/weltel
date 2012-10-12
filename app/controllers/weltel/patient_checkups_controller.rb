#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Weltel
	class PatientCheckupsController < ApplicationController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("private/application")

    #
		def update
      @patient = Weltel::Patient.find(params[:patient_id])
      @checkup = @patient.checkups.find(params[:id])

      @checkup.change_result(params[:current_result].to_sym, authenticated_user) if params[:current_result]
      @checkup.reload
      @checkup.attributes = params.select{|k, v| [:status, :contact_method].include?(k.to_sym)}
      @checkup.save!

      redirect_to(weltel_dashboard_path)
		end
  end
end
