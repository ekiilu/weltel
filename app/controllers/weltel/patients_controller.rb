#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
module Weltel
	class PatientsController < ApplicationController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("private/application")

		#
    before_filter(:only => :index) do
    	session_param(:patients, :search, "")
    	page_param(:patients, 20)
      sort_param(:patients, :user_name, :asc)
      filter_param(:patients)
    end

		# patient list
		def index
			@clinics = Weltel::Clinic
				.sorted_by("name", :asc)

			@patients = Weltel::Patient
				.joins{subscriber}
				.joins{clinic.outer}
				.search(@search)
				.filtered_by(@filter_attribute, @filter_value)
				.sorted_by(@sort_attribute, @sort_order)
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
