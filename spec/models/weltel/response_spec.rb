# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::Response do

	context "validations" do
		subject { create(:response) }

		it { should validate_presence_of(:name) }
		it { should validate_uniqueness_of(:name) }
		it { should ensure_length_of(:name).is_at_most(160) }
		it { should validate_format_of(:name).with("name") }
		it { should validate_format_of(:name).not_with("!") }
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

			responses = Weltel::Response.filtered_by(:name, name)

			responses.count.should == 1
			responses[0].should == expected
		end

		it "sorts" do
			create(:response, :name => "b")
			expected = create(:response, :name => "a")

			responses = Weltel::Response.sorted_by(:name, :asc)

			responses.count.should == 2
			responses[0].should == expected
		end
	end
end
