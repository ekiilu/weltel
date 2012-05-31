# -*- encoding : utf-8 -*-
require "spec_helper"

describe Weltel::Record do
	#
	it "creates an outgoing message" do
		record = create(:record)

		message = record.create_outgoing_message("test")

		message.should be_valid
	end

	#
	it "changes state" do
		record = create(:record)
		new_state = :positive

		record.change_state(new_state)

		record.states.count.should == 1
		record.states.first.state.should  == new_state
	end
end
