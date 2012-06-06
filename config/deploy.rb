# -*- encoding : utf-8 -*-
require "bundler/capistrano"

abort('Please set the cap environment: "cap demo deploy" or "cap local deploy"') unless ARGV[0].match /(local|demo)/

set :application, "weltel"
set :repository,  "ssh://git@dev.verticallabs.ca/git/mambo/apps/weltel.git"
set :deploy_to, "/www/weltel"
set :branch, "3.0"
set :shared_children, %w(system log pids sockets config)
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
  role :web, "localhost"
  role :app, "localhost"
  role :db, "localhost", :primary => true

  set :normal_user, ENV["USER"]
  set :user, normal_user

  after "deploy:setup", "deploy:upload_config"
  before "deploy:assets:precompile", "deploy:symlink_config"
  after "deploy:symlink_config", "deploy:migrate"
  after "deploy:restart", "deploy:delete_deploy_file"

end

task :demo do
  role :web, "dev.verticallabs.ca"
  role :app, "dev.verticallabs.ca"
  role :db, "dev.verticallabs.ca", :primary => true

  set :normal_user, "web"
  set :user, normal_user

  set :ssh_options, {:forward_agent => true}

  after "deploy:setup", "deploy:upload_config"
  before "deploy:assets:precompile", "deploy:symlink_config"
  after "deploy:symlink_config", "deploy:migrate"

end

# helpers
namespace :god do
  [:start, :stop, :restart].each do |command|
    [:unicorn, :dj, :all].each do |component|
      desc "#{command.to_s.capitalize} #{component}"
      task "#{command}_#{component}", :roles => :app , :except => { :no_release => true } do
        god_watch = component != :all ? "mambo_#{component.to_s}" : "mambo"
        run "bundle exec god #{command.to_s} #{god_watch}"
      end
    end
  end

  desc 'Start'
  task :start do
    puts '  * Starting god.'
    run "bundle exec god -P #{shared_path}/pids/god.pid -c #{current_path}/config/god.rb -D"
  end

  desc 'Stop'
  task :stop do
    puts '  * Stopping god.'
    run 'bundle exec god quit', :ignore_failure => true
  end
end

namespace :deploy do
  desc "Deletes deploy file"
  task :delete_deploy_file do
    run("rm -f #{shared_path}/deploy")
  end

  desc "Uploads config"
  task :upload_config, :roles => :app do
    top.upload("./config/app_config.yml", "#{shared_path}/config/app_config.yml")
    top.upload("./config/database.yml", "#{shared_path}/config/database.yml")
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

def with_user(new_user, &block)
  old_user = user
  set :user, new_user
  close_sessions
  yield
  set :user, old_user
  close_sessions
end

def close_sessions
  sessions.values.each { |session| session.close }
  sessions.clear
end

def run_as_sudoer(string, options = {})
  abort("No sudo user.  Please set :sudo_user") if !sudo_user
  puts "  * Sudoing as user #{sudo_user}"
  
  ignore = options[:ignore_failure] ? ' || true' : ''
  command = "sudo sh -c 'RAILS_ENV=#{rails_env}; #{string}#{ignore}'"

  with_user(sudo_user) do
    run "sudo echo \$USER"
    run command 
  end
end

on :finish do
  puts ''
end
