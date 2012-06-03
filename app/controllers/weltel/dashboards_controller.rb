# -*- encoding : utf-8 -*-
module Weltel
	class DashboardsController < ApplicationController
		include Authentication::AuthenticatedController
    include DashboardsHelper

		respond_to(:html)
		layout("private/application")
    before_filter do
      session_param(:page, :dashboard)
      session_param(:search, :dashboard)
      session_param(:view, :dashboard, :study)
      if is_study_dashboard?(@view)
        session_param(:state, :dashboard, :negative)
      else
        session_param(:status, :dashboard, :open)
      end
    end

		#
		def show
      if is_study_dashboard?(@view)
        @patients = Weltel::Patient.active.with_active_record.search(@search).by_state(@state.to_sym).paginate(:page => @page, :per_page => 10)
      else
        @patients = Weltel::Patient.active.with_active_record.search(@search).by_status(@status.to_sym).paginate(:page => @page, :per_page => 10)
      end
			respond_with(@patients)
		end
	end
end
