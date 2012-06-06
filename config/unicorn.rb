# -*- encoding : utf-8 -*-
#init config
require 'yaml'
config_filename = File.expand_path("#{File.dirname(__FILE__)}/unicorn.yml")
config_file = YAML.load(File.read(config_filename))

rails_env = ENV["RAILS_ENV"] || "development"
config = config_file[rails_env]
raise "No config for environment #{rails_env}" unless config

#directories
deploy_dir = config["app_root"]
runtime_dir = config["app_runtime"]
pid_dir = "#{runtime_dir}/pids"
socket_dir = "#{runtime_dir}/sockets"
log_dir = "#{deploy_dir}/log"
gemfile_dir = "#{deploy_dir}"

#workers
worker_processes(config["workers"])
listen("#{socket_dir}/unicorn.sock", :backlog => 64)
listen(config["port"], :tcp_nopush => true)
timeout(30)
pid("#{pid_dir}/mambo_unicorn.pid")
working_directory(deploy_dir)

#logging
stderr_path("#{log_dir}/unicorn.stderr.log")
stdout_path("#{log_dir}/unicorn.stdout.log")

#preloading
preload_app(true)
GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

#disconnect before fork
before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)

  old_pid = "#{pid_dir}/unicorn.pid.oldbin"
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
  ENV["BUNDLE_GEMFILE"] = "#{gemfile_dir}/Gemfile"
end
Unicorn::HttpServer::START_CTX[0] = config["unicorn"]
