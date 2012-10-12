module Weltel
	class Connection < Adapters::Gammu::Connection
		def self.reset
			self.write
			system('god restart mambo_gammu')
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
