#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
		def respond(message)
			# subscriber
			subscriber = message.subscriber

			# unknown subscriber
			return :unknown if subscriber.nil?

			# inactive subscriber
			return :inactive if !subscriber.active?

			# patient
			patient = subscriber.patient

			# inactive patient
			return :inactive if !patient.active?

			# alert
			alerter.alert(patient, message)

			body = message.body.strip.downcase

			return :help if HELP_COMMANDS.include?(body)

			if STOP_COMMANDS.include?(body)
				subscriber.deactivate
				return :stop
			end

			if START_COMMANDS.include?(body)
				subscriber.activate
				return :start
			end

			# checkup
			checkup = patient.current_checkup

			# no record
			return nil if checkup.nil?

			# message add to record
			message.checkup = checkup

			# find response
			response = Weltel::Response.first_by_name(body)

			if response.nil? # unknown response
				checkup.change_result(:unknown, AppConfig.system_user)
			else # known response
				checkup.change_result(response.value.to_sym, AppConfig.system_user)
			end

			# no reply
			nil
		end
	end
end
