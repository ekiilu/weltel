module Weltel
	class Response
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:response, String, {:unique => true, :required => true, :length => 160})
		property(:state, Enum[:positive, :negative], {:index => true, :required => true, :default => :positive})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations

		# associations

		# instance methods
		def response=(response)
			super(response.downcase)
		end

		# class methods
		def self.first_by_response(response)
			first(:response => response)
		end

		def self.search(page, per_page, order)
			page(:page => page, :per_page => per_page, :order => [order])
		end
	end
end
