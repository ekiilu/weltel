require 'recursive_open_struct'

class AppConfig
  def self.load
    filename = "#{Rails.root}/config/app_config.yml"
    YAML.load(File.read(filename))[Rails.env.to_s]
  end

  def self.method_missing(m, *args)
    @data ||= ::RecursiveOpenStruct.new(self.load)
    @data.send(m, *args) 
  end  
end
