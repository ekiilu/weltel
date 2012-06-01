# -*- encoding : utf-8 -*-
module Weltel
	class Alerter
		#
		def initialize(sender)
			@sender = sender
		end

		#
		def alert(patient, message)
			body = "#{patient.user_name}: #{message.body}"

			AppConfig.alert_phone_numbers.each do |phone_number|
				message = Sms::Message.create_to_phone_number(phone_number, body[0..159])
				sender.send(message)
			end
		end

	protected
		attr_reader(:sender)
	end
end
