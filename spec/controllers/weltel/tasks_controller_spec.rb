# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::TasksController do
	#
	it "creates records" do
		create(:message_template, :name => :checkup)
		create(:patient)

		get :create_records
	end

	#
	it "updates records" do
		create(:record)

		get :update_records
	end
end
