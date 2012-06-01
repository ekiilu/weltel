# -*- encoding : utf-8 -*-
module Weltel
	class ResponsesController < ApplicationController
		include Authentication::AuthenticatedController
    include ParamsHelper
		respond_to(:html)
		layout("private/application")

    before_filter(:only => :index) do
      sort_param(:responses)
      filter_param(:responses)
      session_param(:page, :responses)
    end

		#
		def index
			@responses = Weltel::Response.page_and_sort(@page, 20, valid_sort.merge(valid_filter))
			respond_with(@responses)
		end

		#
		def new
			@response = Weltel::Response.new
			respond_with(@response)
		end

		#
		def create
			begin
				@response = Weltel::Response.create(params[:weltel_response])
				flash[:notice] = t(:created)
				respond_with(@response, :location => weltel_responses_path)

			rescue DataMapper::SaveFailureError => error
				@response = error.resource
				respond_with(@response) do |format|
					format.html { render(:new) }
				end
			end
		end

		#
		def edit
			@response = Weltel::Response.get!(params[:id])
			respond_with(@response)
		end

		#
		def update
			begin
				@response = Weltel::Response.get!(params[:id])
				@response.update(params[:weltel_response])
				flash[:notice] = t(:updated)
				respond_with(@response, :location => weltel_responses_path)

			rescue DataMapper::SaveFailureError => error
				@response = error.resource
				respond_with(@response) do |format|
					format.html { render(:edit) }
				end
			end
		end


		#
		def destroy
			@response = Weltel::Response.get!(params[:id])
			@response.destroy
			flash[:notice] = t(:destroyed)
			respond_with(@response, :location => weltel_responses_path)
		end

	private
		#
		def t(key)
			I18n.t(key, :scope => [:weltel, :responses])
		end
	end
end
