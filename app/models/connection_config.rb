class ConnectionConfig < ActiveRecord::Base
  PATH = File.expand_path(File.join('~', '.gammurc'))
  attr_accessible :device, :extra

  def write
    File.open(PATH, 'w') {|f| f.write(text) }
  end

  def text
    <<-eos
[gammu]
  port = #{self.device}
  #{self.extra}
    eos
  end

  def self.send_test(phone_number, message)
    begin
      self.first.write
      success = system "echo \"#{message}\" | /usr/bin/gammu --sendsms TEXT #{phone_number}"
      return success
    rescue Exception => e
      raise e.inspect if Rails.env.development?
      return false
    end
  end
end
