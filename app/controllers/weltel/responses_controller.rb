# -*- encoding : utf-8 -*-
module Weltel
	class ResponsesController < ApplicationController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("private/application")

    before_filter(:only => :index) do
    	page_param(:responses)
      sort_param(:responses, :name, :asc)
      filter_param(:responses)
    end

		#
		def index
			@responses = Weltel::Response
				.filtered_by(@filter_key, @filter_value)
				.sorted_by(@sort_key, @sort_order)
				.paginate(:page => @page, :per_page => 20)
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
				weltel_response = params[:weltel_response]
        if weltel_response[:url_encoded]
          weltel_response[:name] = CGI::unescape(weltel_response[:name])
          weltel_response.delete(:url_encoded)
        end
				@response = Weltel::Response.create(weltel_response)
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
				weltel_response = params[:weltel_response]
				@response = Weltel::Response.get!(params[:id])
				@response.update(weltel_response)
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
