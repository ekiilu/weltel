#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
module Weltel
	class ResponsesController < ApplicationController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("private/application")

		#
    before_filter(:only => :index) do
    	page_param(:responses, 20)
      sort_param(:responses, :name, :asc)
      filter_param(:responses)
    end

		#
		def index
			@responses = Weltel::Response
				.filtered_by(@filter_attribute, @filter_value)
				.sorted_by(@sort_attribute, @sort_order)
				.paginate(:page => @page, :per_page => @per_page)
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
				@response = Weltel::Response.create!(weltel_response)
				flash[:notice] = t(:created)
				respond_with(@response, :location => weltel_responses_path)

			rescue ActiveRecord::RecordInvalid => error
				@response = error.record
				respond_with(@response) do |format|
					format.html { render(:new) }
				end
			end
		end

		#
		def edit
			@response = Weltel::Response.find(params[:id])
			respond_with(@response)
		end

		#
		def update
			begin
				weltel_response = params[:weltel_response]
				@response = Weltel::Response.find(params[:id])
				@response.attributes = weltel_response
				@response.save!
				flash[:notice] = t(:updated)
				respond_with(@response, :location => weltel_responses_path)

			rescue ActiveRecord::RecordInvalid => error
				@response = error.record
				respond_with(@response) do |format|
					format.html { render(:edit) }
				end
			end
		end

		#
		def destroy
			@response = Weltel::Response.find(params[:id])
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
