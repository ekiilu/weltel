# -*- encoding : utf-8 -*-
require 'recursive_open_struct'

class AppConfig
  def self.load
    filename = "#{Rails.root}/config/app_config.yml"
    YAML.load(File.read(filename))
  end

  def self.method_missing(m, *args)
    @data ||= ::RecursiveOpenStruct.new(self.load)
    @data.send(m, *args) 
  end  

  def self.system_user
    @system_user ||= Authentication::User.all(:email_address => 'system@verticallabs.ca').first
  end
end
