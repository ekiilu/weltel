# -*- encoding : utf-8 -*-
module Weltel
	class Clinic
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:system, Boolean, {:required => true, :default => false})
		property(:name, String, {:unique => true, :allow_nil => false, :allow_blank => true, :length => 64})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations
		#validates_length_of(:name, :within => o..64, :allow_blank => true)
		#validates_format_of(:name, :with => /^[\w* ]$/, :allow_blank => true)

		# associations
		has(n, :patients, Weltel::Patient, :constraint => :protect)

		# class methods
		#
		def self.user
			all(:system => false)
		end

		#
		def self.sorted_by(key, order)
			all(:order => [key.send(order)])
		end
	end
end
