class BaseSender
	# instance methods
	#
	def initialize(factory)
		@factory = factory
	end

	#
	def send(message)
		if !Rails.env.test?
			send_message(message)
		else
			false
		end
	end

protected
	#
	attr_reader(:factory)

	#
	def send_message(message)
		raise('abstract')
	end
end