# -*- encoding : utf-8 -*-
require 'recursive_open_struct'
require 'yaml'

class AppConfig
  def self.load(config_file)
    raise "Can't find config_file #{config_file}" unless File.exist?(config_file)
    @data = ::RecursiveOpenStruct.new(YAML.load(File.read(config_file)))
  end

  def self.method_missing(m, *args)
    raise "AppConfig not loaded" unless @data
    @data.send(m, *args)
  end  

  def self.system_user
    @system_user ||= Authentication::User.all(:email_address => 'system@verticallabs.ca').first
  end

  def self.substitute(string, options)
    if string
      options.keys.each do |key|
        string.gsub!("\#\{#{key.to_s.upcase}\}", options[key])
      end
    end
    string
  end

  def self.deployment_processes
    AppConfig.deployment.monitoring.processes.collect do |process_config|
      ::RecursiveOpenStruct.new(process_config.merge(:full_name => "#{self.deployment.monitoring.group_name}_#{process_config['name']}"))
    end
  end
end
