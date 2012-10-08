4# -*- encoding : utf-8 -*-
module Weltel
	class Patient < ActiveRecord::Base
		#
		def self.table_name
			"weltel_patients"
		end

    attr_accessible(:subscriber_attributes, :clinic_id, :active, :user_name, :study_number, :contact_phone_number)

		# validations
    validates(:user_name, :presence => true, :length => {:in => 2..32}, :format => /^\w*$/)
    validates(:study_number, :length => {:maximum => 32}, :format => /^\w*$/, :allow_blank => true)
    validates(:contact_phone_number, :length => {:is => 10}, :format => /^\d*$/, :allow_blank => true)

		# associations
		has_one(:subscriber, :class_name => "Sms::Subscriber", :dependent => :destroy)

		belongs_to(:clinic, :inverse_of => :patients)

		has_many(:records, {:class_name => "Weltel::PatientRecord", :dependent => :destroy, :inverse_of => :patient}) do
			def active
				where(:active => true)
			end
		end

		has_many(:states, {:class_name => "Weltel::PatientRecordState", :through => :records}) do
			def initial
				where(:initial => true)
			end

			def active
				where(:active => true)
			end
		end

		# nested
		accepts_nested_attributes_for(:subscriber)

		# instance methods
		#
		def create_record(date)
			if active_record
				active_record.active = false
				active_record.save!
			end
			active_record = records.create!(:created_on => date)
		end

		# class methods
		# active patients
		def self.active
			where(:active => true)
		end

		# search patients
		def self.search(search)
			return where("1") if search.blank?
			search = "%#{search}%"
			where("user_name LIKE ? OR study_number LIKE ?", search, search)
		end

		# filter patients
		def self.filtered_by(attribute, value)
			return where("1") if value.blank?
			where("#{attribute} = ?", value)
		end

		# sort patients
		def self.sorted_by(attribute, order)
			order("#{attribute} #{order.upcase}")
		end

		# patients with active subscriber
		def self.with_active_subscriber
			joins(:subscriber).where(:subscriber => {:active => true})
		end

		# find by patient state
		def self.with_state(state)
			#joins(:active_record => :active_state).where(:active_record => {:active_state => {:value => state}})
		end

		# find by record status (open/closed)
		def self.with_status(status)
			#joins(:states)
			#joins(:active_record).where(:active_record => {:status => status})
		end

    #
    def self.with_active_record
      joins(:records).where(:record => {:active => true})
    end

		#
    def self.without_active_record
			p = Weltel::Patient.table_name
			pr = Weltel::PatientRecord.table_name
			joins("LEFT JOIN #{pr} ON #{p}.id = #{pr}.patient_id AND #{pr}.active = 1")
			.where("#{pr}.id IS NULL")
    end

		#
		def self.without_active_record_created_on(date)
			p = Weltel::Patient.table_name
			pr = Weltel::PatientRecord.table_name
			joins("LEFT JOIN #{pr} ON #{p}.id = #{pr}.patient_id AND #{pr}.active = 1")
			.where("#{pr.id} IS NULL OR #{pr}.created_on != ?", date)
		end
	end
end
