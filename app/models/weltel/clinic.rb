# -*- encoding : utf-8 -*-
module Weltel
	class Clinic < ActiveModel::Base
    attr_accessors(:system, :name)

		# properties
		#property(:id, Serial)
		#property(:system, Boolean, {:required => true, :default => false})
		#property(:name, String, {:unique => true, :allow_nil => false, :allow_blank => true, :length => 64})
		#property(:created_at, DateTime)
		#property(:updated_at, DateTime)

		# validations
    validates(:name, :length => {:in => 2..64}, :format => /^[\w ]*$/, :allow_blank => true)

		# associations
		has_many(:patients, :dependent => :protect)

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
