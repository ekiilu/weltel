#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module CheckupsHelper
	#
	def checkup_status_t(status)
		I18n.t(status, :scope => [:weltel, :checkups, :statuses])
	end

	#
	def checkup_contact_method_t(contact_method)
		I18n.t(contact_method, :scope => [:weltel, :checkups, :contact_methods])
	end

	#
	def checkup_status_class(status)
		"status #{status}"
	end

	#
	def checkup_status_options
		Weltel::Checkup::STATUSES.map do |status|
			[checkup_status_t(status), status, :class => checkup_status_class(status)]
		end
	end

	#
	def checkup_contact_method_options
		Weltel::Checkup::CONTACT_METHODS.map do |contact_method|
			[checkup_contact_method_t(contact_method), contact_method]
		end
	end
end
