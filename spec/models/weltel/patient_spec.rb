describe Weltel::Patient do
	#
	it "creates a record" do
		patient = create(:patient)

		date = Date.today
		r = patient.create_record(date)

		r.should be_valid
		r.created_on.should == date
	end
end
