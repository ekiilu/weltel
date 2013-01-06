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
			weltel_checkup = params[:weltel_checkup]
      @patient = Weltel::Patient.find(params[:patient_id])
      @checkup = @patient.checkups.find(params[:id])

      current_result = weltel_checkup[:current_result]
      if current_result
				@checkup.change_result(current_result.to_sym, authenticated_user)
				@checkup.reload
			end

			weltel_checkup = weltel_checkup.select{|k,v| [:status].include?(k.to_sym)}
      @checkup.assign_attributes(weltel_checkup)
      @checkup.save!

      redirect_to(weltel_dashboard_path)
		end
  end
end
