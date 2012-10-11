#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

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

		it { should belong_to(:record) }
		it { should belong_to(:user) }
	end

	context "methods" do
	end
end
