#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::PatientMessagesController do

	context "with stubbed authentication" do
		before(:each) do
			@controller.stub(:authenticated_user => build(:user))
		end

		describe "index" do
			before do
				patient = create(:patient)
				get(:index, :patient_id => patient.id)
			end

			#
			it "succeeds" do
				response.should be_success
			end
		end

		describe "new" do
			before do
				patient = create(:patient)
				get(:new, :patient_id => patient.id)
			end

			#
			it "succeeds" do
				response.should be_success
			end
		end

		context "with stubbed sender" do
			before(:each) do
				sender = double
				sender.stub(:send)
				Weltel::Factory.stub(:sender => sender)
			end

			describe "create" do
				before do
					patient = create(:patient)
					message = attributes_for(:message)
					post(:create, :patient_id => patient.id, :message => message)
				end

				it "succeeds" do
					response.should be_redirect
				end
			end
		end
	end
end
