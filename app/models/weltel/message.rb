module Sms
	class Message
		# associations
		belongs_to(:record, Weltel::Record, :required => false)
	end
end
