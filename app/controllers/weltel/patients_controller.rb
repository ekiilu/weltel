# -*- encoding : utf-8 -*-
module Weltel
	class PatientsController < ApplicationController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("private/application")

    before_filter(:only => :index) do
    	session_param_value(:patients, :search, "")
    	page_param(:patients, 20)
      sort_param(:patients, nil, :user_name, :asc)
      filter_param(:patients)
    end

		# patient list
		def index
			@clinics = Weltel::Clinic.sorted_by(:name, :asc)
			@patients = Weltel::Patient
				.includes(:subscriber, :clinic)
				.search(@search)
				.filtered_by(@filter_association, @filter_attribute, @filter_value)
				.sorted_by(@sort_association, @sort_attribute, @sort_order)
				.paginate(:page => @page, :per_page => @per_page)

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
				Weltel::Patient.transaction do
					weltel_patient = params[:weltel_patient]
					@patient = Weltel::Patient.create!(weltel_patient)
					flash[:notice] = t(:created)
					respond_with(@patient, :location => weltel_patients_path)
				end

			rescue ActiveRecord::RecordInvalid => error
				@patient = error.record
				respond_with(@patient) do |format|
					format.html { render(:new) }
				end
			end
		end

		# edit patient form
		def edit
			@patient = Weltel::Patient.find(params[:id])
			respond_with(@patient)
		end

		# update patient
		def update
			begin
				Weltel::Patient.transaction do
					weltel_patient = params[:weltel_patient]
					@patient = Weltel::Patient.find(params[:id])
					@patient.attributes = weltel_patient
					@patient.save!
					flash[:notice] = t(:updated)
					respond_with(@patient, :location => weltel_patients_path)
				end

			rescue ActiveRecord::RecordInvalid => error
				@patient = error.record
				respond_with(@patient) do |format|
					format.html { render(:edit) }
				end
			end
		end

		#
		def destroy
			Weltel::Patient.transaction do
				@patient = Weltel::Patient.find(params[:id])
				@patient.destroy
				flash[:notice] = t(:destroyed)
				respond_with(@patient, :location => weltel_patients_path)
			end
		end

	private
		#
		def t(key)
			I18n.t(key, :scope => [:weltel, :patients])
		end
	end
end
