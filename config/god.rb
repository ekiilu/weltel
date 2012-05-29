#init config
config_filename = File.expand_path("#{File.dirname(__FILE__)}/unicorn.yml")
config_file = YAML.load(File.read(config_filename))
rails_env = ENV["RAILS_ENV"] || "development"
config = config_file[rails_env]
raise "No config for environment #{rails_env}" unless config

#directories
deploy_dir = config["app_root"]
runtime_dir = config["app_runtime"]
pid_dir = "#{runtime_dir}/pids"

God.pid_file_directory = pid_dir

require 'tlsmail'

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

God.watch do |w|
  w.name        = "mambo_dj"
  w.interval    = 30.seconds
  w.dir         = deploy_dir 
  w.env         = { "RAILS_ENV" => rails_env }

  w.start       = "rake jobs:work"

  w.uid         = config['user']
  w.gid         = config['group']
  w.group       = 'mambo'

  # retart if memory gets too high
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
      c.notify = 'Support' if rails_env == 'production'
    end
  end
end

God.watch do |w|
  w.name          = "mambo_unicorn"
  w.interval      = 30.seconds
  w.dir           = deploy_dir 
  w.env           = { "RAILS_ENV" => rails_env }
  w.pid_file      = "#{pid_dir}/unicorn.pid"

  w.start         = "#{config['unicorn']} -E #{rails_env} -c #{deploy_dir}/config/unicorn.rb -D"
  w.stop          = "kill -QUIT #{w.pid_file}"
  w.restart       = "kill -s USR2 #{w.pid_file}"

  w.uid         = config['user']
  w.gid         = config['group']
  w.group       = 'mambo'

  w.behavior(:clean_pid_file)

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
      c.notify = 'Support' if rails_env == 'production'
    end
  end
end
