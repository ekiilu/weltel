# -*- encoding : utf-8 -*-
module Weltel
	class PatientRecord < ActiveRecord::Base
		#
		def self.table_name
			"weltel_patient_records"
		end

		STATUSES = [:open, :closed]
		enum_attr(:status, STATUSES, :init => :open, :nil => false)

		CONTACT_METHODS = [:none, :text, :phone, :email, :outreach_visit, :clinic_visit]
    enum_attr(:contact_method, CONTACT_METHODS, :init => :none, :nil => false)

		# validations
		validates(:active, :inclusion => {:in => [true, false]})
		validates(:created_on, :presence => true)

		# associations
    has_many(:messages, :class_name => "Sms::Message", :dependent => :nullify)
		belongs_to(:patient)
		has_many(:states, :class_name => "Weltel::PatientRecordState", :dependent => :destroy)
		has_one(:active_state, :class_name => "Weltel::PatientRecordState", :conditions => {:active => true})

		# hooks
    #after(:create) do
    #  create_state(:pending, AppConfig.system_user)
    #end

		# instance methods
    #
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
			active_state.update(:active => false) if active_state
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
