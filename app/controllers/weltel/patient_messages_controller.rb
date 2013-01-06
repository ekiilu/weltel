#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Weltel
	class PatientMessagesController < ApplicationController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("private/application")

    before_filter(:only => :index) do
    	page_param(:patient_messages, 20)
      sort_param(:patient_messages, :created_at, :desc)
    end

		# list messages for patient
		def index
			@patient = Weltel::Patient.find(params[:patient_id])
			@messages = @patient
				.subscriber
				.messages
				.sorted_by(@sort_attribute, @sort_order)
				.paginate(:page => @page, :per_page => @per_page)

			@messages.each do |message|
				if message.status == :received
					message.status = :read
					message.save
				end
			end

			respond_with(@patient, @messages)
		end

		# new message form for patient
		def new
			@patient = Weltel::Patient.find(params[:patient_id])
			@message = @patient.subscriber.messages.new
			@message_templates = Sms::MessageTemplate.user

			respond_with(@patient, @message)
		end

		# create a new message for patient
		def create
			begin
				@patient = Weltel::Patient.find(params[:patient_id])

				message_template_id = params[:message_template_id]
				message = params[:message]
				body = message[:body].blank? ? Sms::MessageTemplate.find(message_template_id).body : message[:body]

				ActiveRecord::Base.transaction do
					if @patient.current_checkup
						@message = @patient.current_checkup.send_message(body)
					else
						@message = @patient.subscriber.send_message(body)
					end

					Weltel::Factory.sender.send(@message)
				end

				flash[:notice] = t(:created)

				respond_with(@message, :location => weltel_patient_messages_path(@patient))

			rescue ActiveRecord::RecordInvalid => error
				@message = error.record
				@message_templates = Sms::MessageTemplate.user
				respond_with(@message) do |format|
					format.html { render(:new) }
				end
			end
		end

	private
		#
		def t(key)
			I18n.t(key, :scope => [:weltel, :patient_messages])
		end
	end
end
