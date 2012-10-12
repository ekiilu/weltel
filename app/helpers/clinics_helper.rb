#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
