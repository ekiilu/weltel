# -*- encoding : utf-8 -*-
module Sms
	class Message
		# associations
		belongs_to(:patient_record, Weltel::PatientRecord, :required => false)
	end
end
