# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::PatientRecordState do
	context "validations" do
		subject { create(:patient_record_state) }

		it { should validate_presence_of(:user) }
	end

	#
	context "asscociations" do
		subject { create(:patient_record_state) }

		it { should belong_to(:patient_record) }
		it { should belong_to(:user) }
	end

	context "methods" do
		it "should find active states" do
			create(:patient_record_state, :active => false)
			expected = create(:patient_record_state, :active => true)

			states = Weltel::PatientRecordState.active

			states.count.should == 1
			states[0].should == expected
		end
	end
end
