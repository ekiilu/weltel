# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::PatientRecord do
	#
	it "creates an outgoing message" do
		record = create(:record)

		message = record.create_outgoing_message("test")

		message.should be_valid
	end

	#
	it "changes state" do
		record = create(:record)
		new_state = :positive

		record.change_state(new_state)

		record.states.count.should == 1
		record.states.first.state.should  == new_state
	end

	#
	it "finds active records" do
		create(:record, :active => true)
		create(:record, :active => false)

		records = Weltel::Record.active

		records.count.should == 1
		records[0].active.should == true
	end

	#
	it "finds records created on date" do
		today = Date.today
		create(:record, :created_on => today - 1.day)
		create(:record, :created_on => today)

		records = Weltel::Record.created_on(today)

		records.count.should == 1
		records[0].created_on.should == today
	end

	#
	it "finds records created before date" do
		today = Date.today
		create(:record, :created_on => today - 1.day)
		create(:record, :created_on => today)

		records = Weltel::Record.created_before(today)

		records.count.should == 1
		records[0].created_on.should == today - 1.day
	end

	#
	it "finds records with a specific state" do
		state = :unknown
		expected = create(:record)
		expected.states = create(:state, :state => state)
		record = create(:record)
		record.states = create(:state, :state => :positive)

		records = Weltel::Record.with_state(state)

		records.count.should == 1
		records[0].should == expected
	end
end
