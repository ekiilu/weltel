#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::ResponsesController do

	context "with stubbed authentication" do
		before(:each) do
			@controller.stub(:authenticated_user => build(:user))
		end

		describe "index" do
			before do
				create(:response)
				get(:index)
			end

			#
			it "succeeds" do
				response.should be_success
			end
		end

		describe "new" do
			before do
				get(:new)
			end

			#
			it "succeeds" do
				response.should be_success
			end
		end

		describe "create" do
			before do
				weltel_response = attributes_for(:response)
				post(:create, :weltel_response => weltel_response)
			end

			it "succeeds" do
				response.should be_redirect
			end
		end

		describe "edit" do
			before do
				response = create(:response)
				get(:edit, :id => response.id)
			end

			#
			it "succeeds" do
				response.should be_success
			end
		end

		describe "update" do
			before do
				response = create(:response)
				weltel_response = attributes_for(:response)
				put(:update, :id => response.id, :weltel_response => weltel_response)
			end

			it "succeeds" do
				response.should be_redirect
			end
		end

		describe "destroy" do
			before do
				response = create(:response)
				delete(:destroy, :id => response.id)
			end

			it "succeeds" do
				response.should be_redirect
			end
		end
	end
end
