# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::DashboardsController do
	#
	it "shows" do
		post :show

		response.should be_success
	end
end
