class BaseResponder
	# instance methods
	def initialize(sender)
		@sender = sender
	end

	# respond to messages
	def respond_to_messages(messages, send_responses)
		messages.each do |message|
			# respond to message
			response = respond(message)

			# no response
			next if response.nil?

			# send responses?
			sender.send(response) if send_responses
		end
	end

	# respond to message
	def respond_to_message(message, send_response)
		# get responder and respond to message
		response = respond(message)

		# no response
		return response if response.nil?

		# send response
		sender.send(response) if send_response

		response
	end

protected
	attr_reader(:sender)

	# logger
	def logger
		Rails.logger
	end

	#
	def respond(message)
		begin
			# lowercase body
			body = message.body.downcase

			# help command
			if @@help_commands.include?(body)
				logger.info("Help command: #{message.phone_number} #{message.body}")

				# return reply
				return reply_to(message, help_reply(message))
			end

			# stop command
			if @@stop_commands.include?(body)
				logger.info("Stop command: #{message.phone_number} #{message.body}")

				if !message.subscriber.nil?
					logger.info("For subscriber: #{message.subscriber.inspect}")

					# deactivate
					message.subscriber.active = false

					# save
					message.subscriber.save
				end

				# return reply
				return reply_to(message, stop_reply(message))
			end

			# start command
			if @@start_commands.include?(body)
				logger.info("Start command: #{message.phone_number} #{message.body}")

				if !message.subscriber.nil?
					logger.info("For subscriber: #{message.subscriber.inspect}")

					# activate
					message.subscriber.active = true

					# save
					message.subscriber.save
				end

				# return reply
				return reply_to(message, start_reply(message))
			end

			# thread message
			if !message.subscriber.nil?
				message.parent = message.subscriber.messages.sent.last
			end

			# reply
			logger.info("Message: #{message.phone_number} #{message.body}")

			# return reply
			return reply_to(message, reply(message))

		ensure
			# save message
			message.save
		end
	end

	#
	def help_reply(message)
		raise 'abstract'
	end

	#
	def start_reply(message)
		raise 'abstract'
	end

	#
	def stop_reply(message)
		raise 'abstract'
	end

	#
	def reply(message)
		raise 'abstract'
	end

private
	# class members
	@@start_commands = ['start']
	@@stop_commands = ['stop', 'unsubscribe', 'cancel', 'quit']
	@@help_commands = ['help']

	#
	def reply_to(message, body)
		return nil if body.nil?
		return nil if body.empty?
		return Message.create_reply(message, body)
	end
end
