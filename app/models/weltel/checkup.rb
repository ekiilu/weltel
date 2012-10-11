#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Weltel
	class Checkup < ActiveRecord::Base
		#
		def self.table_name
			"weltel_checkups"
		end

		# attributes
		attr_accessible(
			:current,
			:status,
			:contact_method,
			:created_on)

		STATUSES = [:open, :closed]
		enum_attr(:status, STATUSES, :init => :open, :nil => false)

		CONTACT_METHODS = [:none, :text, :phone, :email, :outreach_visit, :clinic_visit]
    enum_attr(:contact_method, CONTACT_METHODS, :init => :none, :nil => false)

		# validations
		validates(:current, :inclusion => {:in => [true, false]})
		validates(:created_on, :presence => true)

		# associations
		# patient
		belongs_to(:patient,
			:class_name => "Weltel::Patient",
			:inverse_of => :checkups)

		# all results
		has_many(:results,
			:class_name => "Weltel::Result",
			:dependent => :destroy,
			:inverse_of => :checkup) do

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
			:conditions => {:initial => true})

		# current result
		has_one(:current_result,
			:class_name => "Weltel::Result",
			:conditions => {:current => true})

		# messages
    has_many(:messages,
    	:class_name => "Sms::Message",
    	:dependent => :nullify)

		# instance methods
    #
    def contact_method_s
      contact_method != :none ? contact_method.to_s : ""
    end

		#
    def state_changed?
    	raise "fixme"
      #initial_state.value != active_state.value
    end

    #
		def send_message(body)
			messages.create!(
				:subscriber_id => patient.subscriber.id,
				:phone_number => patient.subscriber.phone_number,
				:body => body,
				:status => :sending
			)
		end

		# create a new result
		def create_result(value, user)
			transaction do
				ir = initial_result
				cr = current_result

				if cr
					cr.current = false
					cr.save!
				end

				results.create!(
					:initial => ir.nil?,
					:current => true,
					:value => value,
					:user_id => user.id
				)
			end
		end

		#
		def change_result(value, user)
			transaction do
				self.status = value == :positive ? :closed : :open
				save!

				cr = current_result
				return cr if cr && cr.value == value
				create_result(value, user)
			end
		end

		#
		def archive
			self.current = false
			self.status = :closed
			save!
		end

		# class methods
		#
		def self.current
			where{current == true}
		end

		#
		def self.created_on(date)
			where{created_on == date}
		end

		#
		def self.created_before(date)
			where{created_on < date}
		end

		#
		def self.without_current_result
			joins{current_result.outer}
			.where{current_result == nil}
		end
	end
end
