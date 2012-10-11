#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::PatientRecord do
	#
	context "validations" do
		subject { create(:patient_record) }

		it { should validate_presence_of(:created_on) }
	end

	#
	context "asscociations" do
		subject { create(:patient_record) }
		it { should have_many(:messages).dependent(:nullify) }
		it { should belong_to(:patient) }
		it { should have_many(:states).dependent(:destroy) }
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
			record.states.first.value.should == new_state
		end

		#
		it "finds active records" do
			create(:patient_record, :active => true)
			create(:patient_record, :active => false)

			records = Weltel::PatientRecord.active

			records.count.should == 1
			records[0].active.should == true
		end

		#
		it "finds records created on date" do
			today = Date.today
			create(:patient_record, :created_on => today - 1.day)
			create(:patient_record, :created_on => today)

			records = Weltel::PatientRecord.created_on(today)

			records.count.should == 1
			records[0].created_on.should == today
		end

		#
		it "finds records created before date" do
			today = Date.today
			create(:patient_record, :created_on => today - 1.day)
			create(:patient_record, :created_on => today)

			records = Weltel::PatientRecord.created_before(today)

			records.count.should == 1
			records[0].created_on.should == today - 1.day
		end

		#
		it "finds records with a specific state" do
			state = :unknown
			expected = create(:patient_record_with_state, :state => state)
			record = create(:patient_record_with_state, :state => :positive)

			records = Weltel::PatientRecord.with_state(state)

			records.count.should == 1
			records[0].should == expected
		end
	end
end
