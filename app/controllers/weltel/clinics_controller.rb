# -*- encoding : utf-8 -*-
module Weltel
	class ClinicsController < ApplicationController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("private/application")

    before_filter(:only => :index) do
    	session_param(:clinics, :page, 1)
    	sort_param(:clinics, :name, :asc)
    end

		#
		def index
			@clinics = Weltel::Clinic.user.sorted_by(@sort_key, @sort_order).paginate(:page => 1, :per_page => 2)
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
				@clinic = Weltel::Clinic.create(params[:weltel_clinic])
				flash[:notice] = t(:created)
				respond_with(@clinic, :location => weltel_clinics_path)

			rescue DataMapper::SaveFailureError => error
				@clinic = error.resource
				respond_with(@clinic) do |format|
					format.html { render(:new) }
				end
			end
		end

		#
		def edit
			@clinic = Weltel::Clinic.get!(params[:id])
			respond_with(@clinic)
		end

		#
		def update
			begin
				@clinic = Weltel::Clinic.get!(params[:id])
				@clinic.update(params[:weltel_clinic])
				flash[:notice] = t(:updated)
				respond_with(@clinic, :location => weltel_clinics_path)

			rescue DataMapper::SaveFailureError => error
				@clinic = error.resource
				respond_with(@clinic) do |format|
					format.html { render(:edit) }
				end
			end
		end


		#
		def destroy
			@clinic = Weltel::Clinic.get!(params[:id])
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
