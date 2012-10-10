module Weltel
	class DashboardPatient < ActiveRecord::Base
		#
		def self.table_name
			"weltel_dashboard_patients"
		end
	end
end
