require "spec_helper"

describe Weltel::Responder do
	#
	it "responds to unknown patient" do
		create(:message_template, :name => :unknown)
		message = create(:unknown_message, :body => "test")

		Weltel::Factory.responder.respond_to_message(message, true)
	end

	#
	it "responds to inactive patient" do
		create(:message_template, :name => :inactive)
		message = build(:inactive_message, :body => "test")

		Weltel::Factory.responder.respond_to_message(message, true)
	end

	#
	#it "responds to patient help" do
	#	message = build(:message, :body => "help")
#
	#	Weltel::Factory.responder.respond_to_message(message, true)
	#end

	#
	#it "responds to stop" do
	#	message = build(:message, :body => "stop")

	#	Weltel::Factory.responder.respond_to_message(message, true)
	#end

	#
	#it "responds to start" do
	#	message = build(:message, :body => "start")

#		Weltel::Factory.responder.respond_to_message(message, true)
#	end

	#
#	it "responds to positive" do
#		message = build(:message, :body => "yes")

#		Weltel::Factory.responder.respond_to_message(message, true)
#	end

	#
#	it "responds to negative" do
#		message = build(:message, :body => "no")

#		Weltel::Factory.responder.respond_to_message(message, true)
#	end

	#
#	it "responds to unknown" do
#		message = build(:message, :body => "cat")

#		Weltel::Factory.responder.respond_to_message(message, true)
#	end
end
