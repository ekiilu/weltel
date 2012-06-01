# -*- encoding : utf-8 -*-
module Weltel
	class PatientRecordState
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:active, Boolean, {:index => true, :required => true, :default => true})
		property(:value, Enum[:unknown, :positive, :negative, :late], {:index => true, :required => true, :default => :unknown})
		property(:created_at, DateTime)

		# associations
		belongs_to(:patient_record, Weltel::PatientRecord)

		# class methods
		#
		def self.active
			all(:active => true)
		end
	end
end
