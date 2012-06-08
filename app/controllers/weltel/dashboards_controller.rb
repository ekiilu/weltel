# -*- encoding : utf-8 -*-
module Weltel
	class DashboardsController < ApplicationController
		include Authentication::AuthenticatedController
    include DashboardsHelper

    before_filter do
      page_param(:dashboard)
      sort_param(:dashboard, :user_name, :asc)
      session_param(:view, :per_page, 20)
      session_param(:dashboard, :print, '')
      session_param(:dashboard, :view, :study)
      if is_study_dashboard?(@view)
        session_param(:dashboard, :state, :negative)
      else
        session_param(:dashboard, :status, :open)
      end
    end

		#
		def show
      @patients = Weltel::Patient.active.with_active_record
      if !@search.blank?
        @patients = @patients.search(@search)
      elsif is_study_dashboard?(@view)
        @patients = @patients.with_state(@state.to_sym)
      else
        @patients = @patients.with_status(@status.to_sym)
      end

      @patients = @patients.sorted_by(@sort_key, @sort_order)

      @print = params[:print]
      @patients = @patients.paginate(:page => @page, :per_page => @per_page) if @print.blank?

      respond_to do |format|
        if @print.blank?
          format.html { render :layout => 'private/application' }
        else
          format.html { render 'print', :layout => 'private/print' }
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
