# -*- encoding : utf-8 -*-
module Weltel
	class Record
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:created_on, Date, {:index => true, :required => true})
		property(:state, Enum[:open, :closed], {:index => true, :required => true, :default => :open})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations

		# associations
		has(n, :messages, Sms::Message)
		belongs_to(:patient, Weltel::Patient)
		has(n, :states, Weltel::State, :constraint => :destroy)
		has(1, :last_state, Weltel::State, :order => [:id.desc])

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

		#
		def change_state(state)
			if last_state == nil || last_state.state != state
				states.create(:state => state)
			end
		end

		# class methods

		#
		def self.created_on(date)
			all(:created_on => date)
		end

		#
		def self.with_state(state)
			all(:last_state => nil) || all(:last_state => {:state => state})
		end
	end
end
