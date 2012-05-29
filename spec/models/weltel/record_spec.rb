describe Weltel::Record do
	it "creates an outgoing message" do
		record = create(:record)

		message = record.create_outgoing_message("test")

		message.should be_valid
	end
end
