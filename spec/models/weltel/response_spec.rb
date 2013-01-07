#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::Response do

	context "validations" do
		subject { create(:response) }

		it { should validate_presence_of(:name) }
		it { should validate_uniqueness_of(:name) }
		it { should ensure_length_of(:name).is_at_most(160) }
		it { should validate_format_of(:name).with("name.!? ") }
	end

	#
	context "asscociations" do
	end

	context "methods" do
		it "downcases name" do
			name = "TEST"
			response = create(:response, :name => name)

			response.should be_valid
			response.name.should == name.downcase
		end

		it "filters" do
			name = "test"
			create(:response)
			expected = create(:response, :name => name)

			responses = Weltel::Response.filtered_by("name", name)

			responses.count.should == 1
			responses[0].should == expected
		end

		it "sorts" do
			create(:response, :name => "B")
			expected = create(:response, :name => "A")
			create(:response, :name => "C")

			responses = Weltel::Response.sorted_by("name", :asc)

			responses.count.should == 3
			responses[0].should == expected
		end
	end
end
