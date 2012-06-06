# -*- encoding : utf-8 -*-
module Weltel
	class Patient
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:active, Boolean, {:index => true, :required => true, :default => true})
		property(:user_name, String, {:unique => true, :required => true, :length => 32})
		property(:study_number, String, {:unique => true, :length => 32})
		property(:contact_phone_number, String, :length => 10)
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations
		validates_length_of(:user_name, :within => 2..32)
		validates_format_of(:user_name, :with => /^\w*$/)

		validates_length_of(:study_number, {:within => 1..32, :allow_blank => true})
		validates_format_of(:study_number, {:with => /^\w*$/, :allow_blank => true})

		validates_length_of(:contact_phone_number, {:is => 10, :allow_blank => true})
		validates_format_of(:contact_phone_number, {:with => /^\d*$/, :allow_blank => true})

		# associations
		belongs_to(:subscriber, Sms::Subscriber)
		belongs_to(:clinic, Weltel::Clinic, :required => false)
		has(n, :records, Weltel::PatientRecord, :constraint => :destroy)
		has(1, :active_record, Weltel::PatientRecord, :active => true)
		has(1, :active_state, Weltel::PatientRecordState, :through => :active_record)

		# nested
		accepts_and_validates_nested_attributes_for(:subscriber)

		# instance methods
		#
		def create_record(date)
			active_record.update(:active => false) if active_record
			active_record = records.create(:created_on => date)
			active_record
		end

		# class methods
		# active patients
		def self.active
			all(:active => true)
		end

		# search patients
		def self.search(search)
			if search.nil?  || search.blank?
				all
			else
				search = "%#{search}%"
				all(:user_name.like => search) + all(:study_number.like => search)
			end
		end

		# filter patients
		def self.filtered_by(key, value)
			return all if value.empty?
			case key
			when :clinic
				all(:clinic_id => value)
			end
		end

		# sort patients
		def self.sorted_by(key, order)
			case key
			when :phone_number
				all(:order => subscriber.phone_number.send(order), :links => [relationships[:subscriber].inverse])
			when :clinic
				all(:order => clinic.name.send(order), :links => [relationships[:clinic].inverse])
			else
				all(:order => [key.send(order)])
			end
		end

		# patients with active subscriber
		def self.with_active_subscriber
			all(:subscriber => {:active => true})
		end

		# find by patient state
		def self.with_state(state)
			all(:active_record => {:active_state => {:value => state}})
		end

		# find by record status (open/closed)
		def self.with_status(status)
			all(:active_record => {:status => status})
		end

    #
    def self.with_active_record
      all(:active_record.not => nil)
    end

		#
    def self.without_active_record
    	all(:active_record => nil)
    end

		#
		def self.without_active_record_created_on(date)
			all(:active_record => nil) || all(:active_record => {:created_on.not => date})
		end

		# create
		def self.create_by(params)
			transaction do
				create(params)
			end
		end

		# update
		def self.update_by_id(id, params)
			patient = get!(id)
			transaction do
				patient.update(params)
			end
			patient
		end

		# destroy
		def self.destroy_by_id(id)
			patient = get!(id)
			transaction do
				patient.subscriber.destroy
			end
			patient
		end
	end
end
