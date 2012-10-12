#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::Responder do
	subject { Weltel::Factory.responder }

	#
	it "responds to unknown patient" do
		create(:message_template, :name => :unknown)
		message = create(:unknown_message, :body => "test")

		response = subject.respond_to_message(message, true)

		response.should_not be_nil
	end

	#
	it "responds to inactive patient" do
		create(:message_template, :name => :inactive)
		message = create(:inactive_message, :body => "test")

		response = subject.respond_to_message(message, true)

		response.should_not be_nil
	end

	#
	it "responds to patient help" do
		create(:message_template, :name => :help)
		message = create(:active_message, :body => "help")

		response = subject.respond_to_message(message, true)

		response.should_not be_nil
	end

	#
	it "responds to stop" do
		create(:message_template, :name => :stop)
		message = create(:active_message, :body => "stop")

		response = subject.respond_to_message(message, true)

		response.should_not be_nil
	end

	#
	it "responds to start" do
		create(:message_template, :name => :start)
		message = create(:active_message, :body => "start")

		response = subject.respond_to_message(message, true)

		response.should_not be_nil
	end

	#
	it "responds to positive" do
		create(:response, :name => "yes", :value => :positive)
		message = create(:active_message, :body => "yes")

		response = Weltel::Factory.responder.respond_to_message(message, true)

		response.should be_nil
	end

	#
	it "responds to negative" do
		create(:response, :name => "no", :value => :negative)
		message = create(:active_message, :body => "no")

		response = Weltel::Factory.responder.respond_to_message(message, true)

		response.should be_nil
	end

	#
	it "responds to unknown" do
		message = create(:active_message, :body => "cat")

		response = Weltel::Factory.responder.respond_to_message(message, true)

		response.should be_nil
	end
end
