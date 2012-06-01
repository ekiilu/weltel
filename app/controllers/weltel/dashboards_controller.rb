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
			@patients = Weltel::Patient.all

			respond_with(@patients)
		end
	end
end
