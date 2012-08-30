# -*- encoding : utf-8 -*-
Sms::Subscriber.class_eval do
	# attributes
	attr_accessible(:patient_id)

	# associations
	belongs_to(:patient, :class_name => "Weltel::Patient")
end
