# -*- encoding : utf-8 -*-
module Weltel
	class PatientRecordStaten < ActiveRecord::Base
		#
		def self.table_name
			"weltel_patient_record_states"
		end

    VALUES = [:pending, :unknown, :positive, :negative, :late]

		# properties
		#property(:id, Serial)
		#property(:active, Boolean, {:index => true, :required => true, :default => true})
		#property(:value, Enum[*VALUES], {:index => true, :required => true, :default => :unknown})
		#property(:created_at, DateTime)

    # validations
    #validates(:

		# associations
		belongs_to(:patient_record, :inverse_of => :states)
		belongs_to(:user)

		# class methods
		#
		def self.active
			all(:active => true)
		end
	end
end
