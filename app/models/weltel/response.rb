#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Weltel
	class Response < ActiveRecord::Base
		#
		def self.table_name
			"weltel_responses"
		end

		# attributes
    attr_accessible(
    	:name,
    	:value)

    VALUES = [:positive, :negative]
    enum_attr(:value, VALUES, :init => :positive)

		# validations
    validates(:name,
    	:presence => true,
    	:uniqueness => true,
    	:length => {:maximum => 160},
    	:format => /^[\w\s[:punct:]]*$/)

		# associations

		# instance methods
		def name=(name)
			super(name.blank? ? name : name.downcase)
		end

		# class methods
		def self.get_by_name(value)
			where{name == value.to_s}.first
		end
	end
end
