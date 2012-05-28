describe Weltel::Checkup do
	it "creates an outgoing message" do
		checkup = create(:checkup)

		message = checkup.create_outgoing_message("test")

		message.should be_valid
	end
end
