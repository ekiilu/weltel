#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

class ConnectionConfig < ActiveRecord::Base
  attr_accessible :device, :extra

  after_save :write
  after_save do
    system('god restart mambo_gammu')
  end

  def write
    File.open(AppConfig.deployment.processes.gammu.config_file, 'w') {|f| f.write(text) }
  end

  def text
    database_config = YAML.load_file(File.join(Rails.root, 'config', 'database.yml'))[Rails.env]

    config_string = <<-eos
[gammu]
  port = #{self.device}
  #{self.extra}
[smsd]
  Service = sql
  Driver = native_mysql
  PIN = 1234
  User = #{database_config['username']}
  Password = #{database_config['password']}
  PC = localhost
  Database = #{database_config['database']}
  Logfile = #{AppConfig.deployment.log_directory}/gammu.log
    eos

    logger.debug("Setting gammu config")
    logger.debug(config_string)

    config_string
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

  def self.available_devices
    lines = `ls /dev/ttyUSB* -l`.split
    lines.map {|l| l.match(/ttyUSB\w*/) }.compact.map{|port| "/dev/#{port}"}.uniq
  end
end
