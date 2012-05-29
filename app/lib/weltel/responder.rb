module Weltel
	class Responder < Messaging::Responder
		#
		def initialize(sender, poller, alerter)
			super(sender)
			@poller = poller
			@alerter = alerter
		end

		#
		def receive_responses
			messages = poller.poll
			respond_to_messages(messages, true)
		end

	protected
		attr_reader(:poller)
		attr_reader(:alerter)

		#
		def reply(message)
			key, params = process_message(message)

			return nil if key.nil?

			Sms::MessageTemplate.get_by_name(key).body % params
		end

	private
		HELP_COMMANDS = ["help"]
		STOP_COMMANDS = ["stop", "cancel", "quit", "unsubscribe"]
		START_COMMANDS = ["start"]

		#
		def process_message(message)
			# subscriber
			subscriber = message.subscriber

			# unknown subscriber
			if subscriber.nil?
				return :unknown
			end

			# inactive subscriber
			if !subscriber.active?
				return :inactive
			end

			# patient
			patient = subscriber.patient
			last_record = patient.last_record

			# alert
			alerter.alert(patient, message)

			body = message.body.strip.downcase

			if HELP_COMMANDS.include?(body)
				return :help
			elsif STOP_COMMANDS.include?(body)
				return :stop
			elsif START_COMMANDS.include?(body)
				return :start
			elsif last_record.nil?
				return nil
			end

			last_record.state = :open

			response = Weltel::Response.first_by_name(body)

			if response.nil?
				last_record.change_state(:unknown)
			else
				last_record.change_state(response.state)
			end

			last_record.save

			return nil
		end
	end
end
