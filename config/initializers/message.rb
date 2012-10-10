# -*- encoding : utf-8 -*-
Sms::Message.class_eval do
	# associations
	belongs_to(:checkin,
		:class_name => "Weltel::Checkin")
end
