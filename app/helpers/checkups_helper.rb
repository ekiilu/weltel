#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
module CheckupsHelper
	#
	def checkup_status_options
		Weltel::Checkup::STATUSES.map do |status|
			[I18n.t(status, :scope => [:weltel, :patient_records, :statuses]), status, :class => "status #{status}"]
		end
	end

	#
	def checkup_contact_method_options
		Weltel::Checkup::CONTACT_METHODS.map do |contact_method|
			[I18n.t(contact_method, :scope => [:weltel, :patient_records, :contact_methods]), contact_method]
		end
	end
end
