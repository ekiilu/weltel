FactoryGirl.define do

	factory(:message_template, :class => Sms::MessageTemplate) do
		desc { "#{name}" }
		body { "#{name}" }
  	created_at { DateTime.now }
  	updated_at { DateTime.now }
	end
end
