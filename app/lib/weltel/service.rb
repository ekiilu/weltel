module Weltel
	class Service < Messaging::Service
		# instance methods
		#
		def send_reminders
			patients = Weltel::Patient.active

			body = Sms::MessageTemplate.get_by_name(:reminder).body

			patients.each do |patient|
				Weltel::Patient.transaction do
					message = Sms::Message.create_to_subscriber(patient.subscriber, body)
					sender.send(message)
				end
			end
		end
	end
end
