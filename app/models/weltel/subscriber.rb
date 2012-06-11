# -*- encoding : utf-8 -*-
module Sms
	class Subscriber
		# associations
		has_one(:patient, :dependent => :destroy)
	end
end
