require "spec_helper"

describe Weltel::Response do
	it "downcases responses" do
		r = "TEST"
		response = create(:response, :response => r)

		response.should be_valid
		response.response.should == r.downcase
	end
end