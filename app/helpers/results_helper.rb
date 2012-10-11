#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module ResultsHelper
	#
	RESULT_VALUES = [:pending, :unknown, :positive, :negative, :late]

	#
	def result_value_t(value)
		I18n.t(value, :scope => [:weltel, :results, :values])
  end

	#
  def result_value_class(value)
  	"state #{value}"
  end

  def result_value(result)
  	result.nil? ? :pending : result.value
  end

	#
	def result_value_options
		RESULT_VALUES.map do |value|
			[result_value_t(value), value, :class => result_value_class(value)]
		end
	end
end
