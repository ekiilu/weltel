#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
# Be sure to restart your server when you modify this file.
Weltel::Application.config.session_store(:cookie_store, :key => '_weltel_session')#, :expire_after => 30.minutes)
