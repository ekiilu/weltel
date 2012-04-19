FactoryGirl.define do
	#
	factory(:immunize_patient, :class => Immunize::Patient) do
    source(:sms)
    status(:new)
    association(:subscriber, :factory => :active_subscriber)
	end
end
