# -*- encoding : utf-8 -*-
module Weltel
	class Service < Messaging::Service
		# instance methods
		#
		def archive_records(date)
			Weltel::PatientRecord.transaction do
				Weltel::PatientRecord.active.created_before(date).each do |record|
					record.archive
				end
			end
		end

		#
		def create_records(date)
			archive_records(date)

			body = Sms::MessageTemplate.get_by_name(:checkup).body

			patients = Weltel::Patient.active.with_active_subscriber.without_active_record_created_on(date)

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
			records = Weltel::PatientRecord.active.created_on(date).with_state(:pending)

			Weltel::PatientRecord.transaction do
				records.each do |record|
					record.change_state(:late, AppConfig.system_user)
				end
			end
		end
	end
end
