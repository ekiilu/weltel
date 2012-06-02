# -*- encoding : utf-8 -*-
module Weltel
	class PatientRecordState
		include DataMapper::Resource
    VALUES = [:unknown, :positive, :negative, :late]

		# properties
		property(:id, Serial)
		property(:active, Boolean, {:index => true, :required => true, :default => true})
		property(:value, Enum[*VALUES], {:index => true, :required => true, :default => :unknown})
		property(:created_at, DateTime)
    property(:user_id, Integer)

		# associations
		belongs_to(:patient_record, Weltel::PatientRecord)

		# class methods
		#
		def self.active
			all(:active => true)
		end
	end
end
