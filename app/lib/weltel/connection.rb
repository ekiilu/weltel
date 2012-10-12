module Weltel
  class Connection < ActiveRecord::Base
    def self.available_devices
      lines = `ls /dev/ttyUSB* -l`.split
      lines.map {|l| l.match(/ttyUSB\w*/) }.compact.map{|port| "/dev/#{port}"}.uniq
    end

    def self.valid_keys
      [:device, :extra]
    end

    def self.send_test_sms(phone_number, message)
      raise("Not implemented: please subclass Weltel::Connection")
    end

    def self.send_sms(phone_number, message)
      raise("Not implemented: please subclass Weltel::Connection")
    end

    def self.reset
      raise("Not implemented: please subclass Weltel::Connection")
    end

    def self.received
      raise("Not implemented: please subclass Weltel::Connection")
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
