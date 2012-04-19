if Rails.env.production?
	Twilio::Config.setup(
		:account_sid  => 'AC237b652f53a64bd19e62f62ee2a3d2e4',
		:auth_token   => '0652039bfaaa607bf5af942001dd9b72',
	)
else
	Twilio::Config.setup(
		:account_sid  => 'AC5e98a9a0d24a4dcbbc3126473d142d35',
		:auth_token   => 'da2c9e85efafa8848b3e705ae3a2afe9',
	)
end