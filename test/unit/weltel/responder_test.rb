require 'test_helper'

class Weltel::ResponderTest < ActiveSupport::TestCase
	#
	test 'active patient' do
		subscriber = FactoryGirl.create(:active_subscriber)
	end

	#
	test 'inactive patient' do
		message = FactoryGirl.create(:inactive_subscriber_message)
		response = Immunize::Responder.new.respond_to_message(message, false)

		assert_response(message, :inactive_reply, response)
	end

	#
	test 'help' do
		message = FactoryGirl.create(:help_message)
		response = Immunize::Responder.new.respond_to_message(message, false)

		assert_response(message, :help_reply, response)
	end

	#
	test 'stop' do
		subscriber = FactoryGirl.create(:active_subscriber)
		message = FactoryGirl.create(:stop_message)
		response = Immunize::Responder.new.respond_to_message(message, false)

		assert_response(message, :stop_reply, response)
	end

	#
	test 'start' do
		subscriber = FactoryGirl.create(:inactive_subscriber)
		message = FactoryGirl.create(:start_message)
		response = Immunize::Responder.new.respond_to_message(message, false)

		assert_response(message, :start_reply, response)
	end

private
	#
	def assert_response(message, key, response)
		assert_not_nil(response)
		assert_equal(message.phone_number, response.phone_number)
		assert_equal(message, response.parent)
		assert_equal(I18n.t(key, [:weltel, :messages]), response.body)
	end
end