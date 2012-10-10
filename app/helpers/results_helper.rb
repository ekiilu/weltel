# -*- encoding : utf-8 -*-
module ResultsHelper
	#
	def result_value_options
		Weltel::Result::VALUES.map do |value|
			[I18n.t(value, :scope => [:weltel, :patient_record_states, :values]), value, :class => "state #{value}"]
		end
	end
end
