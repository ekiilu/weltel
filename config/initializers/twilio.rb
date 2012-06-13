# -*- encoding : utf-8 -*-
Twilio::SMS.default_timeout(30)

Twilio::Config.setup(
  :account_sid  => AppConfig.twilio.account_sid,
  :auth_token   => AppConfig.twilio.auth_token
)
