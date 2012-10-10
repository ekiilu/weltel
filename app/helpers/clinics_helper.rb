# -*- encoding : utf-8 -*-
module ClinicsHelper
	#
	def clinic_id_options
		Weltel::Clinic.order(:name).map do |clinic|
			[clinic.name, clinic.id]
		end
	end

	#
	def clinic_name_options
		Weltel::Clinic.order(:name).map do |clinic|
			clinic.name
		end
	end
end
