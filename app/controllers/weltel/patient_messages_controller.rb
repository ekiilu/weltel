# -*- encoding : utf-8 -*-
module Weltel
	class PatientMessagesController < ApplicationController
		include Authentication::AuthenticatedController
		respond_to(:html)
		layout("private/application")

		# list messages for patient
		def index
			@page = params[:page]
			@patient = Weltel::Patient.get!(params[:patient_id])
			@messages = @patient.subscriber.messages.search(@page, 6)

			@messages.select {|message| message.status == :Received}.each do |message|
				message.status = :Read
				message.save
			end

			respond_with(@patient, @messages)
		end

		# new message form for patient
		def new
			@patient = Weltel::Patient.get!(params[:patient_id])
			@message = @patient.subscriber.messages.new
			@message_templates = Sms::MessageTemplate.user

			respond_with(@patient, @message)
		end

		# create a new message for patient
		def create
			begin
				@patient = Weltel::Patient.get!(params[:patient_id])

				body = params[:message][:body]
				if body.empty?
					body = Sms::MessageTemplate.get!(params[:message_template_id]).body
				end

				Weltel::Patient.transaction do
					@message = Sms::Message.create_to_subscriber(@patient.subscriber, body)
					Weltel::Factory.new.sender.send(@message)
				end

				flash[:notice] = t(:created)

				respond_with(@message, :location => weltel_patient_messages_path(@patient))

			rescue DataMapper::SaveFailureError => error
				@message = error.resource
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
