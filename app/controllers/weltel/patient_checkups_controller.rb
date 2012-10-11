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
      @patient_record = @patient.records.find(params[:id])

      @patient_record.change_state(params[:current_state].to_sym, authenticated_user) if params[:current_state]
      @patient_record.reload
      @patient_record.attributes = params.select{|k, v| [:status, :contact_method].include?(k.to_sym)}
      @patient_record.save!

      redirect_to(weltel_dashboard_path)
		end
  end
end
