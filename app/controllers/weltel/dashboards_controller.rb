# -*- encoding : utf-8 -*-
module Weltel
	class DashboardsController < ApplicationController
		include Authentication::AuthenticatedController
    include DashboardsHelper
		respond_to(:html)
		layout("private/application")

    before_filter do
      page_param(:dashboard)
      sort_param(:dashboard, :user_name, :asc)
      session_param(:dashboard, :search, "")
      session_param(:dashboard, :view, :study)
      if is_study_dashboard?(@view)
        session_param(:dashboard, :state, :negative)
      else
        session_param(:dashboard, :status, :open)
      end
    end

		#
		def show
      if is_study_dashboard?(@view)
      	#.with_state(@state.to_sym)
      	#.sorted_by(@sort_key, @sort_order)
        @patients = Weltel::Patient
        	.active
        	.search(@search)
        	.paginate(:page => @page, :per_page => 20)
      else
        	#.with_status(@status.to_sym)
        @patients = Weltel::Patient
        	.active
        	.search(@search)
        	.sorted_by(@sort_key, @sort_order)
        	.paginate(:page => @page, :per_page => 20)
      end
			respond_with(@patients)
		end

	private
		#
		def t(key)
			I18n.t(key, :scope => [:weltel, :dashboards])
		end
	end
end
