# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::Patient do
	#
	it "creates a patient" do
		params = attributes_for(:patient)

		patient = Weltel::Patient.create_by(params)

		patient.should be_valid
	end

	#
	it "updates a patient by id" do
		patient = create(:patient, :user_name => "before")
		after = "test"

		patient = Weltel::Patient.update_by_id(patient.id, {:user_name => after})

		patient.should be_valid
		patient.user_name.should == after
	end

	#
	it "destroys a patient by id" do
		patient = create(:patient)

		Weltel::Patient.destroy_by_id(patient.id)

		Weltel::Patient.get(patient.id).should be_nil
	end

	#
	it "patient creates a record" do
		patient = create(:patient)

		date = Date.today
		r = patient.create_record(date)

		r.should be_valid
		r.created_on.should == date
	end

	#
	it "finds patients with last record created before date" do
		Weltel::Patient.last_record_created_before(Date.today).to_a
	end
end
