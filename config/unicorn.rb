# -*- encoding : utf-8 -*-
app_root = File.expand_path("#{File.dirname(__FILE__)}/..")
require "#{app_root}/lib/app_config.rb"
AppConfig.load("#{app_root}/config/app_config.yml")

config = AppConfig.processes.unicorn

#workers
worker_processes(config.workers)
listen("#{AppConfig.deployment.working_directory}/sockets/unicorn.sock", :backlog => 64)
listen(config.port, :tcp_nopush => true)
timeout(30)
pid("#{AppConfig.deployment.working_directory}/pids/#{config.process_name}.pid")
working_directory(AppConfig.deployment.working_directory)

#logging
stderr_path("#{AppConfig.deployment.log_directory}/#{config.process_name}.stderr.log")
stdout_path("#{AppConfig.deployment.log_directory}/#{config.process_name}.stdout.log")

#preloading
preload_app(true)
GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

#disconnect before fork
before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)

  old_pid = "#{AppConfig.deployment.working_directory}/pids/#{config.process_name}.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

#reconnect after fork
after_fork do |server, worker|
    ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
end

#make sure it"s using the correct gemfile and executable every time
before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{AppConfig.deployment.app_root}/Gemfile"
end
#Unicorn::HttpServer::START_CTX[0] = config["unicorn"]
