# -*- encoding : utf-8 -*-
module ResponsesHelper
	#
	def response_value_options
		[""] + Weltel::Response::VALUES.map do |value|
			[I18n.t("weltel.responses.values.#{value}"), value]
		end
	end
end
