require "spec_helper"

describe Weltel::TasksController do
	#
	it "creates records" do
		create(:message_template, :name => :checkup)
		create(:patient)

		post :create_records
	end

	#
	it "updates records" do
		create(:record)

		post :update_records
	end
end
