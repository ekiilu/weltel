require "spec_helper"

describe Weltel::Service do

	#
	before(:each) do
		sender = double
		sender.stub(:send)
		Weltel::Factory.stub(:sender => sender)
	end

	#
	it "creates records" do
		create(:patient)

		create(:message_template, :name => :checkup)

		Weltel::Factory.service.create_records(Date.today.monday)
	end

	#
	it "creates a record" do
		patient = create(:patient)

		Weltel::Factory.service.create_record(Date.today.monday, patient, "Are you ok?")
	end

	#
	it "updates records" do
		create(:record)

		Weltel::Factory.service.update_records(Date.today.monday)
	end
end
