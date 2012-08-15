# -*- encoding : utf-8 -*-
module Weltel
	class PatientsController < ApplicationController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("private/application")

    before_filter(:only => :index) do
    	page_param(:patients)
      session_param(:view, :per_page, 20)
    	session_param(:patients, :search, "")
      sort_param(:patients, :user_name, :asc)
      filter_param(:patients)
    end

		# patient list
		def index
			@clinics = Weltel::Clinic.sorted_by(:name, :asc)
			@patients = Weltel::Patient.search(@search).filtered_by(@filter_key, @filter_value).sorted_by(@sort_key, @sort_order).paginate(:page => @page, :per_page => @per_page)
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
