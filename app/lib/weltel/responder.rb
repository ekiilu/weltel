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
			# subscriber
			subscriber = message.subscriber

			# unknown subscriber
			if subscriber.nil?
				return Sms::MessageTemplate.get_by_name(:unknown).body
			end

			# inactive subscriber
			if !subscriber.active?
				return Sms::MessageTemplate.get_by_name(:inactive).body
			end

			# patient
			patient = subscriber.patient

			# alert
			alerter.alert(patient, message)

			command = message.body.downcase

			if HELP_COMMANDS.include?(command)
				return Sms::MessageTemplate.get_by_name(:help).body
			elsif STOP_COMMANDS.include?(command)
				return Sms::MessageTemplate.get_by_name(:stop).body
			elsif START_COMMANDS.include?(command)
				return Sms::MessageTemplate.get_by_name(:start).body
			elsif NEGATIVE_COMMANDS.include?(command)
				patient.state = :not_ok
				patient.save
				return nil
			elsif POSITIVE_COMMANDS.include?(command)
				patient.state = :ok
				patient.save
				return nil
			else
				patient.state = :unknown
				patient.save
				return nil
			end
		end

	private
		HELP_COMMANDS = ["help"]
		STOP_COMMANDS = ["stop", "cancel", "quit", "unsubscribe"]
		START_COMMANDS = ["start"]
		POSITIVE_COMMANDS = ["yes"]
		NEGATIVE_COMMANDS = ["no"]
	end
end
