# -*- encoding : utf-8 -*-
require 'tlsmail' || abort("Can't find tlsmail")

app_root = File.expand_path("#{File.dirname(__FILE__)}/..")
require "#{app_root}/lib/app_config.rb"
AppConfig.load("#{app_root}/config/app_config.yml")

pid_directory = "#{AppConfig.deployment.working_directory}/pids" 
God.pid_file_directory = pid_directory 

God::Contacts::Email.defaults do |d|
  Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
  d.delivery_method = :smtp 
  d.server_host = 'smtp.gmail.com' 
  d.server_port = 587 
  d.server_auth = :login
  d.server_domain = 'verticallabs.ca' 
  d.from_email = 'site@verticallabs.ca'
  d.from_name = 'Mambo monitor'
  d.server_user = 'site@verticallabs.ca' 
  d.server_password = 'v3rt1c4l' 
end

God.contact(:email) do |c|
  c.name = 'Support'
  c.group = 'developers'
  c.to_email = 'support@verticallabs.ca'
end

AppConfig.processes.to_h.each_value do |process_config|
  process_config = ::RecursiveOpenStruct.new(process_config)
  pid_file = "#{pid_directory}/#{process_config.process_name}.pid"
  env = {
    :rails_env => AppConfig.deployment.rails_env, 
    :pwd => AppConfig.deployment.app_root,
    :pid_file => pid_file,
    :logfile => "#{AppConfig.deployment.log_directory}/#{process_config.process_name}.log"
  }

  God.watch do |w|
    w.name        = process_config.process_name
    w.interval    = 30.seconds
    w.dir         = env[:pwd]

    w.pid_file    = "#{pid_directory}/#{process_config.process_name}.pid" if !process_config.daemonize
    w.env         = Hash[ env.collect {|k,v| [k.to_s.upcase, v] } ] 
    w.log         = env[:logfile]

    w.group       = AppConfig.deployment.monitoring.group_name, 

    w.start = AppConfig.substitute(process_config.start, env)
    w.stop = AppConfig.substitute(process_config.stop, env)
    w.restart = AppConfig.substitute(process_config.restart, env)

    # restart if memory gets too high
    w.transition(:up, :restart) do |on|
      on.condition(:memory_usage) do |c|
        c.above = 300.megabytes
        c.times = 2
      end
    end

    # determine the state on startup
    w.transition(:init, { true => :up, false => :start }) do |on|
      on.condition(:process_running) do |c|
        c.running = true
      end
    end

    # determine when process has finished starting
    w.transition([:start, :restart], :up) do |on|
      on.condition(:process_running) do |c|
        c.running = true
        c.interval = 5.seconds
      end

      # failsafe
      on.condition(:tries) do |c|
        c.times = 5
        c.transition = :start
        c.interval = 5.seconds
      end
    end

    # start if process is not running
    w.transition(:up, :start) do |on|
      on.condition(:process_running) do |c|
        c.running = false
        c.notify = 'Support' if env[:rails_env] == 'production'
      end
    end
  end
end
