#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
require "bundler/capistrano"
require 'capistrano_colors'

app_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
require "#{app_root}/lib/app_config.rb"

# get a list of all deployments
deployments = Dir.glob(File.join(app_root, 'config', 'deployments', '*')).map {|d| File.basename(d).to_sym }
set :deployment, ARGV[0]
if !deployments.include?(deployment.to_sym)
  abort_message = <<-msg
    Please set the cap deployment: "cap demo deploy" or "cap local deploy"
    Available environments: #{deployments.map{|d| d.to_s}.join(", ")}
    msg
    abort(abort_message)
end
set :deployment_config_path, File.join(File.dirname(__FILE__), 'deployments', deployment.to_s)
AppConfig.load(File.join(deployment_config_path, 'app_config.yml'))

set :application, AppConfig.deployment.app_name
set :repository, AppConfig.deployment.app_repo
set :deploy_to, AppConfig.deployment.deploy_to
set :branch, AppConfig.deployment.app_branch
set :user, AppConfig.deployment.uid
set :rails_env, AppConfig.deployment.rails_env
role :web, AppConfig.deployment.server
role :app, AppConfig.deployment.server
role :db, AppConfig.deployment.server, :primary => true

task deployment do
  #null task, just for syntax
end

# set defaults
set :shared_children, %w(system log pids sockets config tmp)
set :config_files, %w(app_config.yml database.yml)
set :use_sudo, false
set :using_rvm, false
set :scm, :git
set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true

# setup whenever
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

# hooks
before "deploy", "deploy:upload_config"
before "whenever:update_crontab", "deploy:symlink_config"
after "bundle:install", "deploy:migrate"
after "deploy:restart", "deploy:delete_deploy_file"

# helpers
namespace :god do
  [:start, :stop, :restart].each do |command|
    AppConfig.processes.to_h.each_value do |process_config|
      desc "#{command.to_s.capitalize} #{process_config['process_name']}"
      task "#{command}_#{process_config['process_name']}", :roles => :app , :except => { :no_release => true } do
        run "cd #{current_path} && bundle exec god #{command.to_s} #{process_config['process_name']}"
      end
    end
    desc "#{command.to_s.capitalize} all"
    task "#{command}_all", :roles => :app , :except => { :no_release => true } do
      AppConfig.processes.to_h.each_pair do |name, process_config|
        run "cd #{current_path} && bundle exec god #{command.to_s} #{process_config['process_name']}"
      end
    end
  end

  desc 'Start'
  task :start do
    puts '  * Starting god.'
    command = "cd #{current_path} &&"
    command += " bundle exec god"
    command += " -P #{shared_path}/pids/god.pid"
    command += " -c #{current_path}/config/god.rb"
    command += " -l #{File.join(AppConfig.deployment.log_directory, AppConfig.deployment.monitoring.log_file)}"
    run command
  end

  desc 'Restart'
  task :restart do
    stop
    start
  end

  desc 'Stop'
  task :stop do
    puts '  * Stopping god.'
    run "cd #{current_path} && bundle exec god quit || true" #ignore failures
  end

  desc 'Status'
  task :status do
    puts '  * Checking god status'
    run "cd #{current_path} && bundle exec god status || true" #ignore failures
  end
end

namespace :deploy do
  desc "Deletes deploy file"
  task :delete_deploy_file do
    run("rm -f #{shared_path}/deploy || true")
  end

  desc "Uploads config"
  task :upload_config, :roles => :app do
    config_files.each do |filename|
      full_path = File.join(deployment_config_path, filename)
      raise "Missing config file: #{full_path}" unless File.exist?(full_path)
      top.upload(full_path, "#{shared_path}/config/#{filename}")
    end
  end

  desc "Symlinks config"
  task :symlink_config, :roles => :app do
    run("ln -nfs #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml")
    run("ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml")
    run("ln -nfs #{shared_path}/system #{release_path}/public/system")
  end

  # standard tasks (must be implemented to work)
  desc 'Starts server'
  task :start, :roles => :app do
    god.start_all
  end

  desc 'Stops server'
  task :stop, :roles => :app do
    god.stop_all
  end

  desc 'Restarts server'
  task :restart, :roles => :app, :except => { :no_release => true } do
    god.stop
    god.start
    god.restart_all
  end

  desc 'Finalize update'
  task :finalize_update, :except => { :no_release => true } do
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)

    # mkdir -p is making sure that the directories are there for some SCM's that don't
    # save empty folders
    run <<-CMD
      rm -rf #{latest_release}/log #{latest_release}/public/system &&
      mkdir -p #{latest_release}/public &&
      mkdir -p #{latest_release}/tmp &&
      ln -s #{shared_path}/log #{latest_release}/log &&
      ln -s #{shared_path}/system #{latest_release}/public/system
    CMD

    if fetch(:normalize_asset_timestamps, true)
      stamp = Time.now.utc.strftime("%Y%m%d%H%M.%S")
      asset_paths = fetch(:public_children, %w(images stylesheets javascripts)).map { |p| "#{latest_release}/public/#{p}" }.join(" ")
      run "find #{asset_paths} -exec touch -t #{stamp} {} ';'; true", :env => { "TZ" => "UTC" }
    end
  end

  namespace :web do
    desc 'Disable'
    task :disable, :roles => :web, :except => { :no_release => true } do
      on_rollback { run "rm #{shared_path}/system/maintenance.html" }

      require 'sass'
      sass_input = File.read("./app/assets/stylesheets/application.css.sass")
      sass_output = Sass::Engine.new(sass_input).render

      require 'haml'
      haml_input = File.read("./app/views/layouts/maintenance.html.haml")
      haml_output = Haml::Engine.new(template).render

      File.open("htest", 'w').write(result)
      #put result, "#{shared_path}/system/maintenance.html", :mode => 0644
    end
  end
end
