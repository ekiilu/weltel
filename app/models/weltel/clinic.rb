#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Weltel
	class Clinic < ActiveRecord::Base
		#
		def self.table_name
			"weltel_clinics"
		end

    attr_accessible(:system, :name)

		# validations
    validates(:name,
    	:uniqueness => true,
    	:length => {:in => 2..64},
    	:format => /^[\w\s[:punct:]]*$/)

		# associations
		has_many(:patients,
			:class_name => "Weltel::Patient",
			:dependent => :nullify)

		# class methods
		#
		def self.system
			where{system == true}
		end

		def self.user
			where{system == false}
		end
	end
end
