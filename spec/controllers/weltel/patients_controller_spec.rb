# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::PatientsController do

	context "with stubbed authentication" do
		before(:each) do
			@controller.stub(:authenticated_user => build(:user))
		end

		describe "index" do
			before do
				10.times{create(:patient)}
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
				clinic = create(:clinic)
				weltel_patient = attributes_for(:patient, :clinic_id => clinic.id)
				post(:create, :weltel_patient => weltel_patient)
			end

			it "succeeds" do
				response.should be_redirect
			end
		end

		describe "edit" do
			before do
				patient = create(:patient)
				get(:edit, :id => patient.id)
			end

			#
			it "succeeds" do
				response.should be_success
			end
		end

		describe "update" do
			before do
				patient = create(:patient)
				weltel_patient = attributes_for(:patient)
				put(:update, :id => patient.id, :weltel_patient => weltel_patient)
			end

			it "succeeds" do
				response.should be_redirect
			end
		end

		describe "destroy" do
			before do
				patient = create(:patient)
				delete(:destroy, :id => patient.id)
			end

			it "succeeds" do
				response.should be_redirect
			end
		end
	end
end
