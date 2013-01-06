#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Weltel
	class ClinicsController < ApplicationController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("private/application")

    before_filter(:only => :index) do
    	page_param(:clinics, 20)
    	sort_param(:clinics, :name, :asc)
    end

		#
		def index
			@clinics = Weltel::Clinic
				.user
				.sorted_by(@sort_attribute, @sort_order)
				.paginate(:page => @page, :per_page => @per_page)
			respond_with(@clinics)
		end

		#
		def new
			@clinic = Weltel::Clinic.new
			respond_with(@clinic)
		end

		#
		def create
			begin
				weltel_clinic = params[:weltel_clinic]
				@clinic = Weltel::Clinic.create!(weltel_clinic)
				flash[:notice] = t(:created)
				respond_with(@clinic, :location => weltel_clinics_path)

			rescue ActiveRecord::RecordInvalid => error
				@clinic = error.record
				respond_with(@clinic) do |format|
					format.html { render(:new) }
				end
			end
		end

		#
		def edit
			@clinic = Weltel::Clinic.find(params[:id])
			respond_with(@clinic)
		end

		#
		def update
			begin
				weltel_clinic = params[:weltel_clinic]
				@clinic = Weltel::Clinic.find(params[:id])
				@clinic.assign_attributes(weltel_clinic)
				@clinic.save!
				flash[:notice] = t(:updated)
				respond_with(@clinic, :location => weltel_clinics_path)

			rescue ActiveRecord::RecordInvalid => error
				@clinic = error.record
				respond_with(@clinic) do |format|
					format.html { render(:edit) }
				end
			end
		end

		#
		def destroy
			@clinic = Weltel::Clinic.find(params[:id])
			@clinic.destroy
			flash[:notice] = t(:destroyed)
			respond_with(@clinic, :location => weltel_clinics_path)
		end

	private
		#
		def t(key)
			I18n.t(key, :scope => [:weltel, :clinics])
		end
	end
end
