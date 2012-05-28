module Weltel
	class Service < Messaging::Service
		# instance methods
		#
		def send_checkups
			week = Date.today.cweek

			body = Sms::MessageTemplate.get_by_name(:checkup).body

			patients = Weltel::Patient.pending_checkup

			patients.each do |patient|
				send_checkup(patient, body)
			end
		end

		#
		def send_checkup(patient, body)
			Weltel::Patient.transaction do
				checkup = patient.create_checkup

				message = checkup.create_outgoing_message(body)

				sender.send(message)
			end
		end
	end
end
