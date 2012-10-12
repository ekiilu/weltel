#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "spec_helper"

describe Weltel::Checkup do
	#
	context "validations" do
		subject { create(:checkup) }

		it { should validate_presence_of(:created_on) }
	end

	#
	context "asscociations" do
		subject { create(:checkup) }
		it { should have_many(:messages).dependent(:nullify) }
		it { should belong_to(:patient) }
		it { should have_many(:results).dependent(:destroy) }
		it { should have_one(:initial_result) }
		it { should have_one(:current_result) }
	end

	context "instance methods" do
		subject { create(:checkup) }

		#
		it "sends a message" do
			message = subject.send_message("test")
			message.should be_valid
		end

		#
		it "changes result" do
			new_value = :positive
			subject.change_result(new_value, create(:system))
			subject.results.count.should == 1
			subject.results.first.value.should == new_value
		end
	end

	context "class methods" do
		subject { Weltel::Checkup }

		#
		it "finds current" do
			create(:checkup, :current => true)
			create(:checkup, :current => false)

			checkups = subject.current

			checkups.count.should == 1
			checkups[0].current.should == true
		end
	end
end
