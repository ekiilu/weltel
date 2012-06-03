# -*- encoding : utf-8 -*-
module Weltel
	class PatientsController < ApplicationController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("private/application")

    before_filter(:only => :index) do
      sort_param(:patients, :user_name => :asc)
      session_param(:page, :patients)
      session_param(:search, :patients)
    end

		# patient list
		def index
			@clinics = Weltel::Clinic.sorted_by(:name)
			@patients = Weltel::Patient.active.search(@search).paginate(:page => @page, :per_page => 20)
			@patients.clinics.to_a
			@patients.subscribers.to_a
			respond_with(@patients)
		end

		# new patient form
		def new
			@patient = Weltel::Patient.new
			@patient.subscriber = Sms::Subscriber.new
			respond_with(@patient)
		end

		# create new patient
		def create
			begin
				@patient = Weltel::Patient.create_by(params[:weltel_patient])
				flash[:notice] = t(:created)
				respond_with(@patient, :location => weltel_patients_path)

			rescue DataMapper::SaveFailureError => error
				@patient = error.resource
				respond_with(@patient) do |format|
					format.html { render(:new) }
				end
			end
		end

		# edit patient form
		def edit
			@patient = Weltel::Patient.get!(params[:id])
			respond_with(@patient)
		end

		# update patient
		def update
			begin
				@patient = Weltel::Patient.update_by_id(params[:id], params[:weltel_patient])
				flash[:notice] = t(:updated)
				respond_with(@patient, :location => weltel_patients_path)

			rescue DataMapper::SaveFailureError => error
				@patient = error.resource
				respond_with(@patient) do |format|
					format.html { render(:edit) }
				end
			end
		end

		#
		def destroy
			@patient = Weltel::Patient.destroy_by_id(params[:id])
			flash[:notice] = t(:destroyed)
			respond_with(@patient, :location => weltel_patients_path)
		end

	private
		#
		def t(key)
			I18n.t(key, :scope => [:weltel, :patients])
		end
	end
end
