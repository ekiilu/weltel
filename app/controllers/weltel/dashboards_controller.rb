# -*- encoding : utf-8 -*-
module Weltel
	class DashboardsController < ApplicationController
		include Authentication::AuthenticatedController
    include DashboardsHelper

    before_filter do
      page_param(:dashboard, 20)
      sort_param(:dashboard, :user_name, :asc)
      filter_param(:dashboard)
      session_param(:dashboard, :search, "")
      session_param(:dashboard, :view, :study)
      if is_study_dashboard?(@view.to_sym)
        session_param(:dashboard, :state, :negative)
      else
        session_param(:dashboard, :status, :open)
      end
    end

		#
		def show
      @patients = Weltel::Patient
      	.includes(:subscriber, :clinic)
      	.includes(:current_checkup)
      	.includes(:initial_result, :current_result)
      	.active
      	.filtered_by(@filter_attribute, @filter_value)
      	.sorted_by(@sort_attribute, @sort_order)

      if !@search.blank?
        @patients = @patients.search(@search)
      elsif is_study_dashboard?(@view.to_sym)
        @patients = @patients.filter_by_current_result_value(@state.to_sym)
      else
        @patients = @patients.filter_by_current_checkup_status(@status.to_sym)
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
