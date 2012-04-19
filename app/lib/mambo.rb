module Mambo
	mattr_accessor(:project)
	mattr_accessor(:phone_number)
	mattr_accessor(:alert_phone_numbers)
end

Mambo.project = 'ltbi'

if Rails.env.production?
	Mambo.phone_number = '6047572716'
	Mambo.alert_phone_numbers = []
else
	Mambo.phone_number = '7788002767'
	Mambo.alert_phone_numbers = []
end
