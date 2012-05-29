module Weltel
	class Service < Messaging::Service
		# instance methods
		#
		def create_records(date)
			body = Sms::MessageTemplate.get_by_name(:checkup).body

			patients = Weltel::Patient.last_record_created_before(date)

			patients.each do |patient|
				create_record(date, patient, body)
			end
		end

		#
		def create_record(date, patient, body)
			Weltel::Patient.transaction do
				record = patient.create_record(date)

				message = record.create_outgoing_message(body)

				sender.send(message)
			end
		end

		#
		def update_records(date)
			records = Weltel::Record.created_on(date).with_state(:unknown)

			Weltel::Record.transaction do
				records.each do |record|
					record.change_state(:late)
				end
			end
		end
	end
end
