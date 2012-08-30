# -*- encoding : utf-8 -*-
Sms::Message.class_eval do
	# associations
	belongs_to(:patient_record)
end
