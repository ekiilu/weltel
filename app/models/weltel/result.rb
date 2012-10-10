# -*- encoding : utf-8 -*-
module Weltel
	class Result < ActiveRecord::Base
		#
		def self.table_name
			"weltel_results"
		end

		# attributes
		attr_accessible(
			:user_id,
			:initial,
			:current,
			:value)

		VALUES = [:unknown, :positive, :negative, :late]
		enum_attr(:value, VALUES, :init => :unknown, :nil => false)

		# validations
		validates(:user, :presence => true)
		validates(:initial, :inclusion => {:in => [true, false]})
		validates(:current, :inclusion => {:in => [true, false]})
		validates(:value, :presence => true)

		# associations
		# checkup
		belongs_to(:checkup,
			:class_name => "Weltel::Checkup",
			:inverse_of => :results)

		# created by
		belongs_to(:user,
			:class_name => "Authentication::User")

		# class methods
	end
end
