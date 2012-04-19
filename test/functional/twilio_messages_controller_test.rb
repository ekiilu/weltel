require 'test_helper'

class TwilioMessagesControllerTest < ActionController::TestCase

	def setup
		super
		FactoryGirl.create(:project)
	end

	#
	test 'receive immunize message - help' do
		FactoryGirl.create(:immunize_project)

  	post(:create, {
  		:project => 'immunize',
  		:To => '9999999999',
  		:From => '6047338866',
  		:Body => 'help',
  		:SmsSid => random_sid
  	})

		assert_response(:success)
	end

	#
	test 'receive immunize message - hi' do
		FactoryGirl.create(:immunize_project)

  	post(:create, {
  		:project => 'immunize',
  		:To => '9999999999',
  		:From => '6047338866',
  		:Body => 'hi',
  		:SmsSid => random_sid
  	})

		assert_response(:success)
	end

	#
  test 'update status to failed' do
  	message = FactoryGirl.create(:sending_message)

  	post(:update, {
  		:project => 'test',
  		:id => 1,
  		:SmsStatus => 'failed',
  		:SmsSid => random_sid
  	})

  	assert_response(:success)
  end

	#
  test 'update status to sent' do
  	message = FactoryGirl.create(:sending_message)

  	post(:update, {
  		:project => 'test',
  		:id => 1,
  		:SmsStatus => 'sent',
  		:SmsSid => random_sid
  	})

  	assert_response(:success)
  end

	#
  def random_sid
  	(0...20).map{('a'..'z').to_a[rand(26)]}.join
  end
end