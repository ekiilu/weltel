# -*- encoding : utf-8 -*-
module Weltel
	class Patient
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:active, Boolean, {:index => true, :required => true, :default => true})
		property(:user_name, String, {:required => true, :unique => true, :length => 32})
		property(:study_number, String, {:unique => true, :length => 32})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations
		validates_length_of(:user_name, :within => 2..32)
		validates_format_of(:user_name, :with => /^\w*$/)

		validates_length_of(:study_number, {:within => 1..32, :allow_blank => true})
		validates_format_of(:study_number, {:with => /^\w*$/, :allow_blank => true})

		# associations
		belongs_to(:subscriber, Sms::Subscriber)
		has(n, :records, Weltel::PatientRecord, :constraint => :destroy)
		has(1, :active_record, Weltel::PatientRecord, :active => true)

		# nested
		accepts_and_validates_nested_attributes_for(:subscriber)

		# instance methods
		#
		def create_record(date)
			records.create(:created_on => date)
		end

		# class methods
		# active patients
		def self.active
			all(:active => true)
		end

		# filter patients
		def self.search(search)
			if search.nil?
				all
			else
				search = "%#{search}%"
				all(:user_name.like => search) + all(:study_number.like => search)
			end
		end

		# page and order patients
		def self.paginate(page, per_page, options = {})
			page({:page => page, :per_page => per_page}.merge(options))
		end

		#
		def self.with_active_subscriber
			all(:subscriber => {:active => true})
		end

		#
		def self.without_active_record_created_on(date)
			all(:active_record => {:created_on.not => date})
		end

		# find by patient state
		def self.by_state(state)
			all(:active_record => {:active_state => {:value => state}})
		end

		# find by record status (open/closed)
		def self.by_status(status)
			all(:active_record => {:status => status})
		end

    #
    def self.with_active_record
      all(:active_record.not => nil)
    end

		# create
		def self.create_by(params)
			create(params)
		end

		# update
		def self.update_by_id(id, params)
			patient = get!(id)
			patient.update(params)
			patient
		end

		# destroy
		def self.destroy_by_id(id)
			patient = get!(id)
			patient.subscriber.destroy
			patient.destroy
			patient
		end

	end
end
