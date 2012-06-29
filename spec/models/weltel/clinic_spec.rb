require "spec_helper"

describe Weltel::Clinic do
	#
	context "validations" do
		subject { create(:clinic) }
		it { should validate_uniqueness_of(:name) }
		it { should ensure_length_of(:name).is_at_least(2) }
		it { should ensure_length_of(:name).is_at_most(64) }
	end

	#
	context "associations" do
		subject { create(:clinic) }
		it { should have_many(:patients).dependent(:restrict) }
	end
end
