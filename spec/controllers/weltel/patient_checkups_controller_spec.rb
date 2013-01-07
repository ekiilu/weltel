#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "spec_helper"

describe Weltel::PatientCheckupsController do

	context "with stubbed authentication" do
		before(:each) do
			@controller.stub(:authenticated_user => build(:user))
		end

		describe "update" do
			before do
				patient = create(:patient_with_current_checkup)
				post(:update, :patient_id => patient.id, :id => patient.current_checkup.id, :weltel_checkup => {})
			end

			#
			it "succeeds" do
				response.should be_redirect
			end
		end
	end
end
