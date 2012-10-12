#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::Result do
	context "validations" do
		subject { create(:result) }

		it { should validate_presence_of(:user) }
		it { should validate_presence_of(:value) }
	end

	#
	context "asscociations" do
		subject { create(:result) }

		it { should belong_to(:checkup) }
		it { should belong_to(:user) }
	end

	context "methods" do
	end
end
