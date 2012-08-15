# -*- encoding : utf-8 -*-
module Weltel
	class PatientRecordState
		include DataMapper::Resource
    VALUES = [:pending, :unknown, :positive, :negative, :late]

		# properties
		property(:id, Serial)
		property(:active, Boolean, {:index => true, :required => true, :default => true})
		property(:value, Enum[*VALUES], {:index => true, :required => true, :default => :unknown})
		property(:created_at, DateTime)

		# associations
		belongs_to(:patient_record, Weltel::PatientRecord)
		belongs_to(:user, Authentication::User, :required => false)

		# class methods
		#
		def self.active
			all(:active => true)
		end
	end
end
