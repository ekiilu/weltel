# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::ClinicsController do

	context "with stubbed authentication" do
		before(:each) do
			@controller.stub(:authenticated_user => build(:user))
		end

		describe "index" do
			before do
				create(:clinic)
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
				weltel_clinic = attributes_for(:clinic)
				post(:create, :weltel_clinic => weltel_clinic)
			end

			it "succeeds" do
				response.should be_redirect
			end
		end

		describe "edit" do
			before do
				clinic = create(:clinic)
				get(:edit, :id => clinic.id)
			end

			#
			it "succeeds" do
				response.should be_success
			end
		end

		describe "update" do
			before do
				clinic = create(:clinic)
				weltel_clinic = attributes_for(:clinic)
				put(:update, :id => clinic.id, :weltel_clinic => weltel_clinic)
			end

			it "succeeds" do
				response.should be_redirect
			end
		end

		describe "destroy" do
			before do
				clinic = create(:clinic)
				delete(:destroy, :id => clinic.id)
			end

			it "succeeds" do
				response.should be_redirect
			end
		end
	end
end
