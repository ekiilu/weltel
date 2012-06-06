app_root = File.expand_path("#{File.dirname(__FILE__)}/..")
require "#{app_root}/lib/app_config.rb"
AppConfig.load("#{app_root}/config/app_config.yml")

def substitute(string, options)
  options.keys.each do |key|
    string.gsub!("\#\{#{key.to_s.upcase}\}", options[key])
  end
  string
end

Bluepill.application(
  AppConfig.deployment.monitoring.group_name, 
    #:foreground => true,
    :base_dir => AppConfig.deployment.working_directory, 
    :log_file => "#{AppConfig.deployment.log_directory}/#{AppConfig.deployment.monitoring.log_file}"
  ) do |app|

  app.uid = AppConfig.deployment.monitoring.uid 
  app.gid = AppConfig.deployment.monitoring.gid 
  app.working_dir = AppConfig.deployment.app_root

  AppConfig.deployment.monitoring.processes.each do |process_config|
    process_config = ::RecursiveOpenStruct.new(process_config)
    full_name = "#{AppConfig.deployment.monitoring.group_name}_#{process_config.name}"
    app.process(process_config.name) do |process|
      env = {
        :rails_env => AppConfig.deployment.rails_env, 
        :pid => "#{AppConfig.deployment.working_directory}/pids/#{full_name}.pid", 
        :pwd => app.working_dir,
        :logfile => "#{AppConfig.deployment.log_directory}/#{AppConfig.deployment.monitoring.group_name}_#{process_config.name}.log"
      }

      process.environment = env 
      process.start_command = substitute(process_config.start_command, env)
      process.stop_command = substitute(process_config.stop_command, env) if process_config.stop_command
      process.restart_command = substitute(process_config.restart_command, env) if process_config.restart_command
      process.pid_file = env[:pid] 
      process.stdout = process.stderr = env[:logfile] 

      process.stop_signals = [:quit, 15.seconds, :term, 5.seconds, :kill]
      process.start_grace_time = 45.seconds
      process.stop_grace_time = 45.seconds
      process.restart_grace_time = 10.seconds
      process.daemonize = process_config.daemonize

      #process.checks :cpu_usage, :every => 10.seconds, :below => 5, :times => 3        
      #process.checks :mem_usage, :every => 10.seconds, :below => 100.megabytes, :times => [3,5]
    end
  end
end

