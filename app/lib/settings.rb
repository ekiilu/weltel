module Settings
	mattr_accessor(:project)
	mattr_accessor(:alert_phone_numbers)
end

Settings.project = 'ltbi'

if Rails.env.production?
	Settings.alert_phone_numbers = []
else
	Settings.alert_phone_numbers = []
end
