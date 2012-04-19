require 'test_helper'

class Immunize::PatientsControllerTest < ActionController::TestCase
	#
	def setup
		super
		FactoryGirl.create(:immunize_project)
	end

	#
	test 'new patient' do
  	post(:create, {
  		:project => 'immunize',
  		:phone_number => '9999999999',
  		:dates => [2.months.ago, 2.years.from_now]
  	})

		assert_response(:success)
	end
end