# -*- encoding : utf-8 -*-
module PatientRecordHelper
	#
	def patient_record_status_options
		Weltel::PatientRecord.status.options[:flags].map do |status|
			[I18n.t(status, :scope => [:weltel, :patient_records, :statuses]), status]
		end
	end

	#
	def patient_record_contact_method_options
		Weltel::PatientRecord.contact_method.options[:flags].map do |contact_method|
			[I18n.t(contact_method, :scope => [:weltel, :patient_records, :contact_methods]), contact_method]
		end
	end

	def patient_record_state_options
		Weltel::PatientRecordState.value.options[:flags].map do |value|
			[I18n.t(value, :scope => [:weltel, :patient_record_states, :values]), value, :class => "state #{value}"]
		end
	end
end
