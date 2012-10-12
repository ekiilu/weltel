#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
module ResponsesHelper
	#
	def response_value_options
		Weltel::Response::VALUES.map do |value|
			[I18n.t("weltel.responses.values.#{value}"), value]
		end
	end
end
