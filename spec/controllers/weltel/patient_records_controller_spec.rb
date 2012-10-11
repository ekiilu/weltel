#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::PatientRecordsController do

	context "with stubbed authentication" do
		before(:each) do
			@controller.stub(:authenticated_user => build(:user))
		end

		describe "update" do
			before do
				patient = create(:patient)
				post(:update, :patient_id => patient.id, :id => nil)
			end

			#
			it "succeeds" do
				response.should be_success
			end
		end
	end
end
