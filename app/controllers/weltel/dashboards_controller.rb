module Weltel
	class DashboardsController < ApplicationController
		include Authentication::AuthenticatedController
		layout("private/application")

		#
		def show
			@page = params[:page]
			@search = params[:search]
			@patients = Weltel::Patient.search(@page, 6, @search, [:state, :username])
		end
	end
end
