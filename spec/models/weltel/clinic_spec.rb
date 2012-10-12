#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "spec_helper"

describe Weltel::Clinic do
	#
	context "validations" do
		subject { create(:clinic) }
		it { should validate_uniqueness_of(:name) }
		it { should ensure_length_of(:name).is_at_least(2) }
		it { should ensure_length_of(:name).is_at_most(64) }
	end

	#
	context "associations" do
		subject { create(:clinic) }
		it { should have_many(:patients).dependent(:restrict) }
	end

	context "methods" do
		context "class methods" do
			subject { Weltel::Clinic}

			it "filters system" do
				expected = create(:clinic, :system => true)
				create(:clinic, :system => false)

				clinics = subject.system

				clinics.count.should == 1
				clinics[0].should == expected
			end

			it "filters user" do
				create(:clinic, :system => true)
				expected = create(:clinic, :system => false)

				clinics = subject.user

				clinics.count.should == 1
				clinics[0].should == expected
			end

			it "sorts" do
				a = create(:clinic, :name => "AA")
				b = create(:clinic, :name => "BB")
				c = create(:clinic, :name => "CC")

				clinics = subject.sorted_by("name", :desc)

				clinics.count.should == 3
				clinics.should == [c, b, a]
			end
		end
	end
end
