# -*- encoding : utf-8 -*-
module Weltel
	class Clinic
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:name, String, {:unique => true, :required => true, :length => 64})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# associations
		has(n, :patients, Weltel::Patient, :constraint => :set_nil)

		# class methods
		#
		def self.sorted_by(field)
			all(:order => [field])
		end
	end
end
