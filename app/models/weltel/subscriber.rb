module Sms
	class Subscriber
		# associations
		has(1, :patient, Weltel::Patient, :constraint => :destroy)
	end
end
