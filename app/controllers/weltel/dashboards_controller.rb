#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Weltel
	class DashboardsController < ApplicationController
		include Authentication::AuthenticatedController
    include DashboardsHelper

    before_filter do
      page_param(:dashboard, 20)
      sort_param(:dashboard, :user_name, :asc)
      filter_param(:dashboard)
      session_param(:dashboard, :search, "")
      session_param(:dashboard, :view, :todo)
      if is_study_dashboard?(@view.to_sym)
        session_param(:dashboard, :state, :negative)
      else
        session_param(:dashboard, :status, :open)
      end
    end

		#
		def show
      @patients = Weltel::Patient
      	.joins{clinic.outer}
      	.joins{current_checkup}
      	.joins{initial_result.outer}
      	.joins{current_result.outer}
      	.active
      	.filtered_by(@filter_attribute, @filter_value)
      	.sorted_by(@sort_attribute, @sort_order)

      if !@search.blank?
        @patients = @patients.search(@search)
      elsif is_study_dashboard?(@view.to_sym)
        @patients = @patients.filter_by_current_result_value(@state)
      else
        @patients = @patients.filter_by_current_checkup_status(@status)
      end

      @print = params[:print]
      @patients = @patients.paginate(:page => @page, :per_page => @per_page) if @print.blank?

      respond_to do |format|
        if @print.blank?
          format.html { render :layout => "private/application" }
        else
          format.html { render "print", :layout => "private/print" }
        end
      end
		end

	private
		#
		def t(key)
			I18n.t(key, :scope => [:weltel, :dashboards])
		end
	end
end
