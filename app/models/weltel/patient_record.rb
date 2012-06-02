# -*- encoding : utf-8 -*-
module Weltel
	class PatientRecord
		include DataMapper::Resource
    STATUSES = [:open, :closed] 

		# properties
		property(:id, Serial)
		property(:active, Boolean, {:index => true, :required => true, :default => true})
		property(:created_on, Date, {:index => true, :required => true})
		property(:status, Enum[*STATUSES], {:index => true, :required => true, :default => :open})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations

		# associations
		has(n, :messages, Sms::Message)
		belongs_to(:patient, Weltel::Patient)
		has(n, :states, Weltel::PatientRecordState, :constraint => :destroy)
		has(1, :active_state, Weltel::PatientRecordState, :active => true)

    after :create do
      create_state(:unknown)
    end

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
		def create_state(value)
			self.states.create(:value => value)
		end

		#
		def change_state(value)
			Weltel::PatientRecord.transaction do
				status = value == :positive ? :open : :closed
				save

				if active_state == nil
					create_state(value)
				elsif active_state.value == value
					active_state
				else
					active_state.active = false
					active_state.save
					create_state(value)
				end
			end
		end

		#
		def close
			record.active = false
			record.status = :closed
			record.save
		end

		# class methods
		#
		def self.active
			all(:active => true)
		end

		#
		def self.created_on(date)
			all(:created_on => date)
		end

		#
		def self.created_before(date)
			all(:created_on.lt => date)
		end

		#
		def self.with_state(state)
			all(:active_state => {:state => state})
		end
	end
end
