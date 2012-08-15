# -*- encoding : utf-8 -*-
Twilio::SMS.default_timeout(30)

Twilio::Config.setup(
	:account_sid  => AppConfig.twilio.account_sid,
	:auth_token   => AppConfig.twilio.auth_token
)

#:account_sid  => 'AC5e98a9a0d24a4dcbbc3126473d142d35',
#:auth_token   => 'da2c9e85efafa8848b3e705ae3a2afe9',
