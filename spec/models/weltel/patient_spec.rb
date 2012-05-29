describe Weltel::Patient do

	#
	it "creates a record" do
		patient = create(:patient)

		r = patient.create_record

		r.should be_valid
	end


	#
	it "returns patient if last record created before date" do

	end
end
