module Weltel
	class Connection < Adapters::Gammu::Connection
		def self.reset
			self.write
			system('god restart mambo_gammu')
		end
	end
end
