class BaseService
	#
	def initialize(sender)
		@sender = sender
	end

protected
	#
	attr_reader(:sender)
end