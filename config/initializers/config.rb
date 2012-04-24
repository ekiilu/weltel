config_filename = File.expand_path("#{File.dirname(__FILE__)}/../config.yml")
CONFIG = YAML.load(File.read(config_filename)).symbolize_keys