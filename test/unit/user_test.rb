require 'test_helper'

class UserTest < ActiveSupport::TestCase
	#
  test "create" do
		system = User.create({
			:role => :Administrator,
			:name => 'System',
			:email_address => 'system@verticallabs.ca',
			:verified => true,
			:password => 'password',
			:password_confirmation => 'password'})
  end
end