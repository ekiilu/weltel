# -*- encoding : utf-8 -*-
module ClinicsHelper
	#
	def clinic_options
		Weltel::Clinic.all(:order => :name).map do |clinic|
			[clinic.name, clinic.id]
		end
	end
end
