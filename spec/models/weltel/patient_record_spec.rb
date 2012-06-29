# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::PatientRecord do
	#
	context "validations" do
		subject { create(:patient_record) }

		it { ensure_inclusion_of(:active).in_range([true, false]) }
		it { validate_presence_of(:created_on) }
	end

	#
	context "asscociations" do
	end

	context "methods" do
		#
		it "creates an outgoing message" do
			record = create(:patient_record)

			message = record.create_outgoing_message("test")

			message.should be_valid
		end

		#
		it "changes state" do
			system = create(:system)
			record = create(:patient_record)
			new_state = :positive

			record.change_state(new_state, system)

			record.states.count.should == 1
			record.states.first.state.should  == new_state
		end

		#
		it "finds active records" do
			create(:patient_record, :active => true)
			create(:patient_record, :active => false)

			records = Weltel::patient_record.active

			records.count.should == 1
			records[0].active.should == true
		end

		#
		it "finds records created on date" do
			today = Date.today
			create(:patient_record, :created_on => today - 1.day)
			create(:patient_record, :created_on => today)

			records = Weltel::patient_record.created_on(today)

			records.count.should == 1
			records[0].created_on.should == today
		end

		#
		it "finds records created before date" do
			today = Date.today
			create(:patient_record, :created_on => today - 1.day)
			create(:patient_record, :created_on => today)

			records = Weltel::patient_record.created_before(today)

			records.count.should == 1
			records[0].created_on.should == today - 1.day
		end

		#
		it "finds records with a specific state" do
			state = :unknown
			expected = create(:patient_record)
			expected.states = create(:state, :state => state)
			record = create(:patient_record)
			record.states = create(:state, :state => :positive)

			records = Weltel::patient_record.with_state(state)

			records.count.should == 1
			records[0].should == expected
		end
	end
end
