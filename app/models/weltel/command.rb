module Weltel
	class Command
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:name, String, {:unique => true, :required => true, :length => 160})
		property(:state, Enum[:positive, :negative], {:index => true, :required => true, :default => :positive})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations

		# associations

		# class methods
		def self.first_by_name(name)
			first(:name => name)
		end
	end
end
