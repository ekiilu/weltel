# -*- encoding : utf-8 -*-
module Weltel
	class Clinic < ActiveRecord::Base
		#
		def self.table_name
			"weltel_clinics"
		end

    attr_accessible(:system, :name)

		# validations
    validates(:name, :uniqueness => true, :length => {:in => 2..64}, :format => /^[\w ]*$/, :allow_blank => true)

		# associations
		has_many(:patients, :dependent => :restrict)

		# class methods
		#
		def self.system
			where{system == true}
		end

		def self.user
			where{system == false}
		end

		#
		def self.sorted_by(key, order)
			order{__send__(key).__send__(order)}
		end
	end
end
