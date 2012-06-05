# -*- encoding : utf-8 -*-
module Weltel
	class ResponsesController < ApplicationController
		include Authentication::AuthenticatedController

		respond_to(:html)
		layout("private/application")

    before_filter(:only => :index) do
    	page_param(:responses)
      sort_param(:responses, :name, :asc)
    end

		#
		def index
			@responses = Weltel::Response.sorted_by(@sort_key, @sort_order).paginate(:page => @page, :per_page => 20)
			respond_with(@responses)
		end

		#
		def new
			@value_options = value_options
			@response = Weltel::Response.new
			respond_with(@response)
		end

		#
		def create
			begin
				weltel_response = params[:weltel_response]
				weltel_response[:name] = CGI::unescape(weltel_response[:name]) if params[:url_encoded]
				#weltel_response[:value] = weltel_response[:value].to_sym
				@response = Weltel::Response.create(weltel_response)
				flash[:notice] = t(:created)
				respond_with(@response, :location => weltel_responses_path)

			rescue DataMapper::SaveFailureError => error
				@value_options = value_options
				@response = error.resource
				respond_with(@response) do |format|
					format.html { render(:new) }
				end
			end
		end

		#
		def edit
			@value_options = value_options
			@response = Weltel::Response.get!(params[:id])
			respond_with(@response)
		end

		#
		def update
			begin
				weltel_response = params[:weltel_response]
				#weltel_response[:value] = weltel_response[:value].to_sym
				@response = Weltel::Response.get!(params[:id])
				@response.update(weltel_response)
				flash[:notice] = t(:updated)
				respond_with(@response, :location => weltel_responses_path)

			rescue DataMapper::SaveFailureError => error
				@value_options = value_options
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
		def value_options
			Weltel::Response.value.options[:flags].map { |value| [t(".#{value}"), value] }
		end

		#
		def t(key)
			I18n.t(key, :scope => [:weltel, :responses])
		end
	end
end
