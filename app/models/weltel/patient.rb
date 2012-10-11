#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Weltel
	class Patient < ActiveRecord::Base

		include Support::ModelHelper

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
		# active patients
		def self.active
			where{active == true}
		end

		# search patients
		def self.search(search)
			return where{true} if search.blank?
			search = "%#{search}%"
			where{(user_name =~ search) | (study_number =~ search)}
		end

    #
    def self.with_current_checkup
      joins{current_checkup}
    end

		#
    def self.with_current_checkup_not_created_on(date)
    	joins{current_checkup}
    	.where{current_checkup.created_on != date}
    end

		#
    def self.without_current_checkup
			joins{current_checkup.outer}
			.where{current_checkup.id == nil}
    end

		#
    def self.filter_by_current_checkup_status(status)
    	where{current_checkup.status == status}
    end

		#
    def self.filter_by_initial_result_value(value)
			where{initial_result.value == value}
    end

		#
    def self.filter_by_current_result_value(value)
			where{current_result.value == value}
    end
	end
end
