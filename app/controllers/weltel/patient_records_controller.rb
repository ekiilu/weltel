# -*- encoding : utf-8 -*-
module Weltel
	class PatientRecordsController < ApplicationController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("private/application")

    #
		def update
      @patient = Weltel::Patient.get!(params[:patient_id])
      @patient_record = @patient.records.get(params[:id])

      @patient_record.change_state(params[:current_state].to_sym, authenticated_user) if params[:current_state]
      @patient_record.reload
      @patient_record.update(params.select{|k, v| [:status, :contact_method].include?(k.to_sym)})

      redirect_to(weltel_dashboard_path)
		end
  end
end
