# -*- encoding : utf-8 -*-
module Weltel
	class Response
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:name, String, {:unique => true, :required => true, :length => 160})
		property(:value, Enum[:positive, :negative], {:index => true, :required => true, :default => :positive})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations

		# associations

		# instance methods
		def name=(name)
			super(name.downcase)
		end

		# class methods
		def self.first_by_name(name)
			first(:name => name)
		end

		# page and order
		def self.page_and_sort(page, per_page, sort)
			page(:page => page, :per_page => per_page, :order => sort)
		end
	end
end
