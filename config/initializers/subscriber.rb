# -*- encoding : utf-8 -*-
module Sms
	class Subscriber < ActiveRecord::Base
		# associations
		has_one(:patient, {:class_name => "Weltel::Patient", :dependent => :destroy})
	end
end
