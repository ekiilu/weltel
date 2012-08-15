# -*- encoding : utf-8 -*-
module Weltel
	class Alerter
		#
		def initialize(sender)
			@sender = sender
		end

		#
		def alert(patient, message)
			body = "#{patient.user_name}: #{message.body}"[0..159]

			Authentication::User.with_phone_number.each do |user|
				message = Sms::Message.create_to_phone_number(user.phone_number, body)
				sender.send(message)
			end
		end

	protected
		attr_reader(:sender)
	end
end
