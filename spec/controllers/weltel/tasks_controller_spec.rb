#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "spec_helper"

describe Weltel::TasksController do

	let!(:message_template) { create(:message_template, :name => :checkup) }
	let!(:patient) { create(:patient) }
	let!(:system) { create(:system) }
	let!(:checkup) { create(:checkup) }

	#
	describe '#create_checkups' do
		context 'working' do
			it "creates checkups" do
				get :create_checkups

				response.body.should == "OK"
				response.status.should == 200
			end
		end

		context 'failing' do
			it 'returns 404' do
				Weltel::Service.any_instance.stub(:create_checkups).and_raise(Exception.new)

				get :create_checkups

				response.status.should == 404
			end
		end
	end

	describe '#update_checkups' do
		context 'working' do
			it "updates checkups" do
				get :update_checkups

				response.body.should == "OK"
				response.status.should == 200
			end
		end

		context 'failing' do
			it 'returns 404' do
				Weltel::Factory.service.stub(:update_checkups).and_raise(Exception.new)

				get :update_checkups

				response.status.should_not == 404
			end
		end
	end
end
