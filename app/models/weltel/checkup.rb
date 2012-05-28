module Weltel
	class Checkup
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:active, Boolean, {:required => true, :default => true})
		property(:classification, Enum[:unknown, :positive, :negative, :none], {:index => true, :required => true, :default => :unknown})
		property(:outcome, Enum[:unknown, :positive, :negative], {:index => true, :required => true, :default => :unknown})
		property(:state, Enum[:open, :closed], {:required => true, :default => :open})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations

		# associations
		belongs_to(:patient, "Weltel::Patient")
		has(n, :messages, "Sms::Message")

		# instance methods
		#
		def create_outgoing_message(body)
			messages.create(
				:subscriber => patient.subscriber,
				:phone_number => patient.subscriber.phone_number,
				:body => body,
				:status => :Sending
			)
		end

		# class methods
		#
		def self.active
			all(:active => true)
		end
	end
end
