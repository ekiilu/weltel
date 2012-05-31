# -*- encoding : utf-8 -*-
module Weltel
	class State
		include DataMapper::Resource

		# properties
		property(:id, Serial)
		property(:state, Enum[:unknown, :positive, :negative, :late], {:index => true, :required => true, :default => :unknown})
		property(:created_at, DateTime)

		# associations
		belongs_to(:record, Weltel::Record)
	end
end
