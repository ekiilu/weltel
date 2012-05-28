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

			Sms::MessageTemplate.get_by_name(:key).body % params
		end

	private
		HELP_COMMANDS = ["help"]
		STOP_COMMANDS = ["stop", "cancel", "quit", "unsubscribe"]
		START_COMMANDS = ["start"]
		POSITIVE_COMMANDS = ["yes"]
		NEGATIVE_COMMANDS = ["no"]

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
			last_checkup = patient.last_checkup

			# alert
			alerter.alert(patient, message)

			command = message.body.downcase

			if HELP_COMMANDS.include?(command)
				return :help
			elsif STOP_COMMANDS.include?(command)
				return :stop
			elsif START_COMMANDS.include?(command)
				return :start
			elsif NEGATIVE_COMMANDS.include?(command)
				last_checkup.classification = :negative
				return nil
			elsif POSITIVE_COMMANDS.include?(command)
				last_checkup.classification = :positive
				return nil
			else
				last_checkup.classification = :unknown
				return nil
			end
		end
	end
end
