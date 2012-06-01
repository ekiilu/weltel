# -*- encoding : utf-8 -*-
module Weltel
	class DashboardsController < ApplicationController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("private/application")

		#
		def show
			@page = params[:page]
			@search = params[:search]
			@patients = Weltel::Patient.active.filter(@search).page_and_sort(@page, 20, :user_name)
			respond_with(@patients)
		end
	end
end
