require "spec_helper"

describe Weltel::Service do

	before(:each) do
		sender = double
		sender.stub(:send)
		Weltel::Factory.stub(:sender => sender)
	end

	it "sends checkups" do
		create(:message_template, :name => :checkup)

		Weltel::Factory.service.send_checkups
	end

	it "sends a checkup" do
		patient = create(:patient)

		Weltel::Factory.service.send_checkup(patient, 0, "test")
	end
end
