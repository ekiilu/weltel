#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
Twilio::SMS.default_timeout(30)

Twilio::Config.setup(
  :account_sid  => AppConfig.twilio.account_sid,
  :auth_token   => AppConfig.twilio.auth_token
)
