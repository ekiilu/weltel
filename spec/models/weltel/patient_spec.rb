#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
		it { should have_one(:subscriber) }
		it { should belong_to(:clinic) }
		it { should have_many(:checkups).dependent(:destroy) }
		it { should have_one(:current_checkup) }
		it { should have_many(:results).through(:checkups) }
		it { should have_one(:initial_result) }
		it { should have_one(:current_result) }
	end

	#
	context "methods" do

		context "class methods" do
			subject { Weltel::Patient }

			#
			it "finds active patients" do
				expected = create(:patient)
				create(:patient, :active => false)
				patients = subject.active
				patients.count.should == 1
				patients[0].should == expected
			end

			#
			it "searches all patients when searching for blank" do
				expected = create(:patient)
				patients = subject.search(nil)
				patients.count.should == 1
				patients[0].should == expected
			end

			#
			it "searches patients with matching user name" do
				search = "test"
				create(:patient)
				expected = create(:patient, :user_name => search)
				patients = subject.search(search[1..2])
				patients.count.should == 1
				patients[0].should == expected
			end

			#
			it "searches patients with matching study number" do
				search = "test"
				create(:patient)
				expected = create(:patient, :study_number => search)

				patients = subject.search(search[1..2])

				patients.count.should == 1
				patients[0].should == expected
			end

			#
			it "filters" do
				create(:patient)
				create(:patient)
				expected = create(:patient)

				c = Weltel::Clinic.table_name
				patients = subject.joins{clinic}.filtered_by("clinic.id", expected.clinic.id)

				patients.count.should == 1
				patients[0].should == expected
			end

			#
			it "sorts by attribute" do
				c = create(:patient, :user_name => "CC")
				a = create(:patient, :user_name => "AA")
				b = create(:patient, :user_name => "BB")

				patients = subject.sorted_by("user_name", :asc)

				patients.count.should == 3
				patients.should == [a, b, c]
			end

			it "creates csv data" do
				3.times { create(:patient) }
				subject.to_csv.should be_a(String)
				(subject.to_csv.split("\n").size-1).should == subject.all.size
			end
		end
	end
end
