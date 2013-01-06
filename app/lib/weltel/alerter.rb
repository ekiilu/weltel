#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Weltel
	class Alerter
		#
		def initialize(sender)
			@sender = sender
		end

		#
		def alert(patient, message)
			length = patient.user_name.length + 2
			body = "#{patient.user_name}: #{message.body}"[0..length]

			Authentication::User.with_phone_number.each do |user|
				message = Sms::Message.send_message(user.phone_number, body)
				sender.send(message)
			end
		end

	protected
		attr_reader(:sender)
	end
end
