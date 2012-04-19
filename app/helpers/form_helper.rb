module FormHelper

	def options_for_enum(enum, val)
		options_for_select(enum.options[:flags], val)
	end
end
