module Gammu
  class Connection < Weltel::Connection
    def self.send_test_sms(phone_number, message)
      begin
        self.write
        self.reset
        success = system "echo \"#{message}\" | /usr/bin/gammu --sendsms TEXT #{phone_number}"
        return success
      rescue Exception => e
        raise e.inspect if Rails.env.development?
        return false
      end
    end

    def self.send_sms(phone_number, message)
      query = <<-q
        INSERT INTO outbox (DestinationNumber,  TextDecoded,  CreatorID,  Coding) 
        VALUES ('#{phone_number}', '#{message}', 'Weltel System','Default_No_Compression');
      q
      ActiveRecord::Base.connection.execute(query)
      true
    end

    def self.reset
      self.write
      system('god restart mambo_gammu')
    end

    def self.received
      Gammu::InboxItem.all.map do |item| 
        {
          :phone_number => item.read_attribute(:SenderNumber),
          :message => item.read_attribute(:TextDecoded),
          :time => item.read_attribute(:ReceivingDateTime)
        } 
      end
    end

    def self.clear_received
      Gammu::InboxItem.destroy_all
    end

    def self.write
      File.open(AppConfig.deployment.processes.gammu.config_file, 'w') {|f| f.write(text) }
    end

    def self.text
      database_config = YAML.load_file(File.join(Rails.root, 'config', 'database.yml'))[Rails.env]
      connection_config = self.load_config(:current)

      config_string = <<-eos
  [gammu]
    port = #{connection_config.device}
    #{connection_config.extra}
  [smsd]
    Service = sql
    Driver = native_mysql
    User = #{database_config['username']}
    Password = #{database_config['password']}
    PC = localhost
    Database = #{database_config['database']}
    Logfile = #{AppConfig.deployment.log_directory}/gammu.log
    DeliveryReport = sms
    ResetFrequency = 300
    MaxRetries = 3
    #DebugLevel = 2
      eos

      logger.debug("Setting gammu config")
      logger.debug(config_string)

      config_string
    end

  end
end
