# -*- encoding : utf-8 -*-
module Weltel
	class Response < ActiveRecord::Base
		#
		def self.table_name
			"weltel_responses"
		end

		# attributes
    attr_accessible(:name, :value)

    VALUES = [:positive, :negative]
    enum_attr(:value, VALUES, :init => :positive)

		# validations
    validates(:name, :presence => true, :uniqueness => true, :length => {:maximum => 160}, :format => /^[\w ]*$/)

		# associations

		# instance methods
		def name=(name)
			super(name.blank? ? name : name.downcase)
		end

		# class methods
		#
		def self.filtered_by(key, value)
			return all if value.blank?
			where{key == value}
		end

		#
		def self.sorted_by(key, order)
			order{__send__(key).__send__(order)}
		end
	end
end
