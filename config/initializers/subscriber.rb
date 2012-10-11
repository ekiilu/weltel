#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
Sms::Subscriber.class_eval do
	# attributes
	attr_accessible(:patient_id)

	# associations
	belongs_to(:patient,
		:class_name => "Weltel::Patient")
end
