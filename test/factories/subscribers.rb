FactoryGirl.define do
	#
	factory(:active_subscriber, :class => Subscriber) do
		phone_number('9999999999')
		active(true)
	end

	#
	factory(:inactive_subscriber, :class => Subscriber) do
		phone_number('8888888888')
		active(false)
	end
end
