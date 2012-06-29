# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::Patient do
	#
	context "validations" do
		subject { create(:patient) }
		it { should validate_presence_of(:user_name) }
		it { should ensure_length_of(:user_name).is_at_least(2) }
		it { should ensure_length_of(:user_name).is_at_most(32) }
		it { should ensure_length_of(:study_number).is_at_most(32) }
		#it { should ensure_length_of(:contact_phone_number).is_equal_to(10) }
	end

	#
	context "associations" do
		subject { create(:patient) }
		it { should belong_to(:subscriber) }
		it { should belong_to(:clinic) }
		it { should have_many(:records).dependent(:destroy) }
		it { should have_one(:active_record) }
		it { should have_one(:active_state).through(:active_record) }
	end

	#
	context "methods" do
		#
		it "updates a patient by id" do
			patient = create(:patient)
			expected = "test"
			patient = Weltel::Patient.update_by_id(patient.id, :user_name => expected)
			patient.should be_valid
			patient.user_name.should == expected
		end

		#
		it "destroys a patient by id" do
			patient = create(:patient)
			Weltel::Patient.destroy_by_id(patient.id)
			#patient.should_not exist
		end

		#
		#it "patient creates a record" do
		#	patient = create(:patient)

		#	date = Date.today
		#	r = patient.create_record(date)

		#	r.should be_valid
		#	r.created_on.should == date
		#end
	end
end
