#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "spec_helper"

describe Weltel::Service do
	#
	it "creates checkups" do
		create(:patient)
		create(:message_template, :name => :checkup)

		Weltel::Factory.service.create_checkups(Date.today.monday)
	end

	#
	it "updates checkups" do
		create(:system)
		create(:checkup)

		Weltel::Factory.service.update_checkups
	end
end
