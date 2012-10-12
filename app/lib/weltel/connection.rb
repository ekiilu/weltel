module Weltel
	class Connection < Adapters::Gammu::Connection
		def self.reset
			self.write
			system('god restart mambo_gammu')
		end

    def self.save_config(name, hash)
      hash.each do |k, v|
        Weltel::Config.create!(:name => name.to_s, :key => k.to_s, :value => v.to_s)
      end
    end

    def self.load_config(name)
      RecursiveOpenStruct.new(Hash[Weltel::Config.where(:name => name.to_s).map {|item| [item.key.to_sym, item.value]}])
    end
	end
end
