# -*- encoding : utf-8 -*-
module Weltel
	class PatientRecord
		include DataMapper::Resource
    STATUSES = [:open, :closed]
    CONTACT_METHODS = [:none, :text, :phone, :email, :outreach_visit, :clinic_visit]

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
		has(n, :messages, Sms::Message, :constraint => :set_nil)
		belongs_to(:patient, Weltel::Patient)
		has(n, :states, Weltel::PatientRecordState, :constraint => :destroy)
		has(1, :active_state, Weltel::PatientRecordState, :active => true)

		# hooks
    after(:create) do
      create_state(:pending, AppConfig.system_user)
    end

		# instance methods
    #
    def contact_method_s
      contact_method != :none ? contact_method.to_s : ''
    end

    def state_changed?
      initial_state.value != active_state.value
    end

    def initial_state
      states.all(:value.not => :pending).first || states.first
    end

    #
		def create_outgoing_message(body)
			messages.create(
				:subscriber => patient.subscriber,
				:phone_number => patient.subscriber.phone_number,
				:body => body,
				:status => :sending
			)
		end

		#
		def create_state(value, user)
			states.update(:active => false)
			states.create(:value => value, :user => user)
			active_state.reload
		end

		#
		def change_state(value, user)
			Rails.logger.debug(value)
			Weltel::PatientRecord.transaction do
				self.status = value == :positive ? :closed : :open
				save

				if active_state.value == value
					active_state
				else
					create_state(value, user)
				end
			end
		end

		#
		def archive
			update(:active => false, :status => :closed)
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
		def self.with_state(value)
			all(:active_state => {:value => value})
		end
	end
end
