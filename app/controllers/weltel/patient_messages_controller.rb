# -*- encoding : utf-8 -*-
module Weltel
	class PatientMessagesController < ApplicationController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("private/application")

    before_filter(:only => :index) do
    	page_param(:patient_messages, 20)
      sort_param(:patient_messages, "", :created_at, :desc)
    end

		# list messages for patient
		def index
			@patient = Weltel::Patient.find(params[:patient_id])
			@messages = @patient
				.subscriber
				.messages
				.sorted_by(@sort_attribute, @sort_order)
				.paginate(:page => @page, :per_page => @per_page)

			@messages.select{|message| message.status == :received}.each do |message|
				message.update(:status => :read)
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

				body = params[:message][:body]
				if body.blank?
					body = Sms::MessageTemplate.find(params[:message_template_id]).body
				end

				Weltel::Patient.transaction do
					if @patient.active_record
						@message = @patient.active_record.send_message(body)
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
