describe Weltel::Patient do

	it "creates a checkup" do
		patient = create(:patient)

		c = patient.create_checkup(0)

		c.should be_valid
		c.week.should == 0
	end
end
