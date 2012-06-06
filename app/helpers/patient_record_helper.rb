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
end
