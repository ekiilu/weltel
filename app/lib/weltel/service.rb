module Weltel
	class Service < Messaging::Service
		# instance methods
		#
		def send_reminders
			patients = Weltel::Patient.active

			patients.each do |patient|
				Weltel::Patient.transaction do
					patient.reminder = Message.create_to_subscriber(patient.subscriber, t(:patient_reminder))
					patient.response = nil
					patient.save
					sender.send(patient.reminder)
				end
			end
		end

	private
		#
		def t(key)
			I18n.t(key, :scope => [:weltel, :messages])
		end
	end
end
