# -*- encoding : utf-8 -*-
module Weltel
	class PatientRecord
		include DataMapper::Resource
    STATUSES = [:open, :closed] 
    CONTACT_METHODS = [:none, :text, :phone] 

		# properties
		property(:id, Serial)
		property(:active, Boolean, {:index => true, :required => true, :default => true})
		property(:created_on, Date, {:index => true, :required => true})
		property(:status, Enum[*STATUSES], {:index => true, :required => true, :default => :open})
    property(:contact_method, Enum[*CONTACT_METHODS], {:index => true, :required => true, :default => :none})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations

		# associations
		has(n, :messages, Sms::Message)
		belongs_to(:patient, Weltel::Patient)
		has(n, :states, Weltel::PatientRecordState, :constraint => :destroy)
		has(1, :active_state, Weltel::PatientRecordState, :active => true)

    after :create do
      create_state(:unknown, AppConfig.system_user)
    end

		# instance methods
    #
    def initial_state
      states.all(:value.not => :unknown, :order => [:created_at.asc]).first || states.first
    end

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
		def create_state(value, user)
			self.states.create(:value => value, :user_id => user.id)
		end

		#
		def change_state(value, user)
			Weltel::PatientRecord.transaction do
				status = value == :positive ? :open : :closed
				save

				if active_state.value == value
					active_state
				else
					active_state.active = false
					active_state.save
					create_state(value, user)
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
