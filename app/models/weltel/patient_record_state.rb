# -*- encoding : utf-8 -*-
module Weltel
	class PatientRecordState < ActiveRecord::Base
		#
		def self.table_name
			"weltel_patient_record_states"
		end

		# attributes
		attr_accessible(:user_id, :active, :value)

		VALUES = [:pending, :unknown, :positive, :negative, :late]
		enum_attr(:value, VALUES, :init => :unknown, :nil => false)

		# associations
		belongs_to(:patient_record, :inverse_of => :states)
		belongs_to(:user, :class_name => "Authentication::User")

		# validations
		validates(:user, :presence => true)
		validates(:active, :inclusion => {:in => [true, false]})
		validates(:value, :presence => true)

		# class methods
		#
		def self.active
			where{active == true}
		end
	end
end
