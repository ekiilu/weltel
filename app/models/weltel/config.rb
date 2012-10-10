module Weltel
  class Config < ActiveRecord::Base
    def self.set(name, hash)
      hash.each do |k, v|
        self.where(:name => name.to_s, :key => k.to_s).first_or_create(:value => v.to_s)
      end
    end

    def self.get(name)
      Hash[self.where(:name => name.to_s).map {|item| [item.key.to_sym, item.value]}]
    end
  end
end
