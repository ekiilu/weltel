# -*- encoding : utf-8 -*-
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
			return :unknown if subscriber.nil?

			# inactive subscriber
			return :inactive if !subscriber.active?

			# patient
			patient = subscriber.patient

			# record
			record = patient.records.last

			# alert
			alerter.alert(patient, message)

			body = message.body.strip.downcase

			return :help if HELP_COMMANDS.include?(body)
			return :stop if STOP_COMMANDS.include?(body)
			return :start if START_COMMANDS.include?(body)
			return nil if record.nil?

			record.state = :open

			response = Weltel::Response.first_by_response(body)

			if response.nil?
				record.change_state(:unknown)
			else
				record.change_state(response.state)
			end

			record.save

			nil
		end
	end
end
