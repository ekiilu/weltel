module Weltel
	class Response
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:name, String, {:unique => true, :required => true, :length => 160})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations

		# associations

		# class methods
		def self.get_by_name(name)
			first(:name => name) || raise("#{name} not_found")
		end
	end
end
