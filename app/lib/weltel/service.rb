module Weltel
	class Service < Messaging::Service
		# instance methods
		#
		def send_reminders
			patients = Weltel::Patient.pending

			body = Sms::MessageTemplate.get_by_name(:reminder).body

			patients.each do |patient|
				Weltel::Patient.transaction do
					patient.state = :unknown
					patient.week = Date.today.cweek
					patient.save

					message = Sms::Message.create_to_subscriber(patient.subscriber, body)

					sender.send(message)
					sleep(1)
				end
			end
		end
	end
end
