# -*- encoding : utf-8 -*-
module Sms
	class Message < ActiveRecord::Base
		# associations
		belongs_to(:patient_record)
	end
end
