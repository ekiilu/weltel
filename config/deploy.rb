# -*- encoding : utf-8 -*-
require "bundler/capistrano"
require 'capistrano_colors'

app_root = File.expand_path("#{File.dirname(__FILE__)}/..")
require "#{app_root}/lib/app_config.rb"
AppConfig.load("#{app_root}/config/app_config.yml")

abort('Please set the cap environment: "cap demo deploy" or "cap local deploy"') unless ARGV[0].match /(local|demo)/

set :application, "weltel"
set :repository,  "ssh://git@dev.verticallabs.ca/git/mambo/apps/weltel.git"
set :deploy_to, "/www/weltel"
set :branch, "3.0"
set :shared_children, %w(system log pids sockets config)
set :config_files, %w(app_config.yml database.yml)
set :sudo_user, ENV["USER"]

set :use_sudo, false
set :using_rvm, false
set :scm, :git
set :rake, "bundle exec rake"
set :deploy_via, :remote_cache
set :rails_env, 'production'
ssh_options[:forward_agent] = true

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

task :local do
  set :deployment, :local
  set :user, ENV["USER"]

  role :web, "localhost"
  role :app, "localhost"
  role :db, "localhost", :primary => true

  after "deploy:setup", "deploy:upload_config"
  before "deploy:assets:precompile", "deploy:symlink_config"
  after "deploy:symlink_config", "deploy:migrate"
  after "deploy:restart", "deploy:delete_deploy_file"

end

task :demo do
  set :deployment, :demo
  set :user, 'web'

  role :web, "dev.verticallabs.ca"
  role :app, "dev.verticallabs.ca"
  role :db, "dev.verticallabs.ca", :primary => true

  set :ssh_options, {:forward_agent => true}

  after "deploy:setup", "deploy:upload_config"
  before "deploy:assets:precompile", "deploy:symlink_config"
  after "deploy:symlink_config", "deploy:migrate"
end

# helpers
namespace :god do
  [:start, :stop, :restart].each do |command|
    AppConfig.processes.each do |process_config|
      desc "#{command.to_s.capitalize} #{process_config.process_name}"
      task "#{command}_#{process_config.process_name}", :roles => :app , :except => { :no_release => true } do
        run "cd #{current_path} && bundle exec god #{command.to_s} #{process_config.process_name}"
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
    run("rm -f #{shared_path}/deploy")
  end

  desc "Uploads config"
  task :upload_config, :roles => :app do
    config_files.each do |filename|
      full_path = "#{File.dirname(__FILE__)}/deployments/#{deployment}/#{filename}"
      top.upload(full_path, "#{shared_path}/config/#{filename}")
    end 
  end

  desc "Symlinks config"
  task :symlink_config, :roles => :app do
    run("ln -nfs #{deploy_to}/shared/config/app_config.yml #{release_path}/config/app_config.yml")
    run("ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml")
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
end

on :finish do
  puts ''
end
