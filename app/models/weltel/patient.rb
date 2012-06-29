# -*- encoding : utf-8 -*-
module Weltel
	class Patient < ActiveRecord::Base
		#
		def self.table_name
			"weltel_patients"
		end

    attr_accessible(:active, :user_name, :study_number, :contact_phone_number)

		# validations
    validates(:user_name, :presence => true, :length => {:in => 2..32}, :format => /^\w*$/)
    validates(:study_number, :length => {:maximum => 32}, :format => /^\w*$/, :allow_blank => true)
    validates(:contact_phone_number, :length => {:is => 10}, :format => /^\d*$/, :allow_blank => true)

		# associations
		belongs_to(:subscriber, :class_name => "Sms::Subscriber")
		belongs_to(:clinic, :inverse_of => :patients)
		has_many(:records, {:class_name => "Weltel::PatientRecord", :dependent => :destroy})
		has_one(:active_record, {:class_name => "Weltel::PatientRecord", :conditions => {:active => true}})
		has_one(:active_state, :through => :active_record)

		# nested
		accepts_nested_attributes_for(:subscriber)

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
			if search.blank?
				all
			else
				search = "%#{search}%"
				all(:user_name.like => search) + all(:study_number.like => search)
			end
		end

		# filter patients
		def self.filtered_by(key, value)
			return all if value.blank?
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
			transaction do
				update(id, params)
			end
		end

		# destroy
		def self.destroy_by_id(id)
			patient = find(id)
			transaction do
				patient.subscriber.destroy
			end
			patient
		end
	end
end
