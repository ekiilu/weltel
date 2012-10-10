# -*- encoding : utf-8 -*-
module Weltel
	class Patient < ActiveRecord::Base
		#
		def self.table_name
			"weltel_patients"
		end

    attr_accessible(
    	:subscriber_attributes,
    	:clinic_id,
    	:active,
    	:user_name,
    	:study_number,
    	:contact_phone_number)

		# validations
    validates(:user_name, :presence => true, :length => {:in => 2..32}, :format => /^\w*$/)
    validates(:study_number, :length => {:maximum => 32}, :format => /^\w*$/, :allow_blank => true)
    validates(:contact_phone_number, :length => {:is => 10}, :format => /^\d*$/, :allow_blank => true)

		# associations
		# subscriber
		has_one(:subscriber,
			:class_name => "Sms::Subscriber",
			:dependent => :destroy)

		# clinic
		belongs_to(:clinic,
			:class_name => "Weltel::Clinic",
			:inverse_of => :patients)

		# all checkups
		has_many(:checkups,
			:class_name => "Weltel::Checkup",
			:dependent => :destroy,
			:inverse_of => :patient) do

			# current checkups
			def current
				where(:current => true).first
			end
		end

		# current checkup
		has_one(:current_checkup,
			:class_name => "Weltel::Checkup",
			:inverse_of => :patient,
			:conditions => {:current => true})

		# all results
		has_many(:results,
			:class_name => "Weltel::Result",
			:through => :checkups) do

			# initial result
			def initial
				where(:initial => true).first
			end

			# current result
			def current
				where(:current => true).first
			end
		end

		# initial result
		has_one(:initial_result,
			:class_name => "Weltel::Result",
			:through => :current_checkup,
			:source => :initial_result)

		# current result
		has_one(:current_result,
			:class_name => "Weltel::Result",
			:through => :current_checkup,
			:source => :current_result)

		# nested
		accepts_nested_attributes_for(:subscriber)

		# instance methods
		# create a checkup for date
		def create_checkup(date)
			transaction do
				c = current_checkup
				if c
					c.current = false
					c.save!
				end
				checkups.create!(
					:current => true,
					:created_on => date
				)
			end
		end

		# class methods
		#
		def self.join_subscriber
			joins(:subscriber)
		end

		#
		def self.join_clinic
			joins("LEFT JOIN weltel_clinics ON weltel_patients.clinic_id = weltel_clinics.id")
		end

		#
		def self.join_records
			joins(:records)
		end

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
			joins(:subscriber)
			.where(:sms_subscribers => {:active => true})
		end

    #
    def self.with_current_checkup
      joins(:current_checkup)
    end

		#
    def self.with_current_checkup_not_created_on(date)
    	joins(:current_checkup)
    	.where("weltel_checkups.created_on != ?", date)
    end

		#
    def self.without_current_checkup
			includes(:current_checkup)
			.where(:weltel_checkups => {:id => nil})
    end

		#
    def self.filter_by_current_checkup_status(status)
    	where(:weltel_checkups => {:status => status})
    end

		#
    def self.filter_by_initial_result_value(value)
			where(:weltel_results => {:value => value})
    end

		#
    def self.filter_by_current_result_value(value)
			where(:current_results_weltel_patients => {:value => value})
    end
	end
end
