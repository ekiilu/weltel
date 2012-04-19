module Weltel
	class Project
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:name, String, {:required => true, :unique => true, :length => 64})
		property(:state, Json, :default => '{}')
		property(:active, Boolean, {:required => true, :default => true})
		property(:created_at, DateTime)
		property(:updated_at, DateTime)

		# validations
		validates_length_of(:name, {:min => 3, :max => 64})
		validates_format_of(:name, :with => /^[a-zA-Z0-9_]*$/)

		# class methods
		#
		def self.active
			all(:active => true)
		end

		#
		def self.get_active_by_name(name)
			active.first(:name => name) || raise('not_found')
		end

		#
		def self.find_active_by_name(name)
			active.first(:name => name)
		end
	end
end
