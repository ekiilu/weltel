worker_processes 1

app_name = "weltel"
is_production = ENV["RAILS_ENV"] == "production"
deploy_directory = File.expand_path(is_production ? "/www/#{app_name}/shared" : "#{File.dirname(__FILE__)}/../tmp")
pid_directory = "#{deploy_directory}/pids"
socket_directory = "#{deploy_directory}/sockets"
log_directory = File.expand_path(is_production ? "/www/#{app_name}/shared/log" : "#{File.dirname(__FILE__)}/../log")

listen "#{socket_directory}/unicorn.sock", :backlog => 64
listen 3000, :tcp_nopush => true

timeout 30

pid "#{pid_directory}/unicorn.pid"

stderr_path "#{log_directory}/unicorn.stderr.log"
stdout_path "#{log_directory}/unicorn.stdout.log"

preload_app true

GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

before_fork do |server, worker|
  old_pid = "#{pid_directory}/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
      `service nginx reload`
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
