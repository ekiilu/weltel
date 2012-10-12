#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
class DevelopmentMailInterceptor
	#
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "#{ ENV['USER'] }@verticallabs.ca"
  end
end
