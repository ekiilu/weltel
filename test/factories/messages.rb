FactoryGirl.define do
	#
	factory(:sending_message, :class => Message) do
		id(1)
		phone_number('9999999999')
		body('sending')
		status(:Sending)
	end

	#
	factory(:unknown_subscriber_message, :class => Message) do
		phone_number('9999999999')
		body('hi')
	end

	factory(:inactive_subscriber_message, :class => Message) do
		phone_number('8888888888')
		body('hi')
		association(:subscriber, :factory => :inactive_subscriber)
	end

	factory(:help_message, :class => Message) do
		phone_number('9999999999')
		body('help')
	end

	factory(:stop_message, :class => Message) do
		phone_number('9999999999')
		body('stop')
	end

	factory(:start_message, :class => Message) do
		phone_number('8888888888')
		body('start')
	end
end