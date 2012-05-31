# -*- encoding : utf-8 -*-
module FormHelper
	#
	def options_for_enum(enum, val = nil)
		options_for_select(enum.options[:flags].map {|option| [option.capitalize, option]}, val)
	end
end
