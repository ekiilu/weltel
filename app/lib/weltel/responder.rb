module Weltel
	class Responder < Messaging::Responder
		#
		def initialize(sender, poller, alerter)
			super(sender)
			@poller = poller
			@alerter = alerter
		end

		#
		def receive_responses(last_receive)
			messages = poller.poll(last_receive)
			respond_to_messages(messages, true)
		end

	protected
		attr_reader(:poller)
		attr_reader(:alerter)

		#
		def help_reply(message)
			t(:help_reply)
		end

		#
		def start_reply(message)
			t(:start_reply)
		end

		#
		def stop_reply(message)
			t(:stop_reply)
		end

		#
		def reply(message)
			# find patient
			subscriber = message.subscriber

			# unknown subscriber
			if subscriber.nil?
				return t(:unknown_patient_reply)
			end

			# inactive subscriber
			if !subscriber.active?
				return t(:inactive_patient_reply)
			end

			# load patient
			patient = Weltel::Patient.first_by_subscriber(subscriber)

			# alert
			alerter.alert(patient, message)

			if patient.response.nil?
				# update patient state
				command = message.body.downcase
				case
				when NEGATIVE.include?(command)
					patient.state = false
				when POSITIVE.include?(command)
					patient.state = true
				else
					patient.state = nil
				end

				# save response
				patient.response = message
				patient.save
			end

			# no reply
			nil
		end

	private
		POSITIVE = ['yes']
		NEGATIVE = ['no']

		# translate
		def t(key)
			I18n.t(key, :scope => [:weltel, :messages])
		end
	end
end
