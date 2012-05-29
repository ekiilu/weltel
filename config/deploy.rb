require "bundler/capistrano"

abort('Please set the cap environment: "cap demo deploy" or "cap local deploy"') unless ARGV[0].match /(local|demo)/

set :application, "weltel"
set :repository,  "ssh://git@dev.verticallabs.ca/git/mambo/apps/weltel.git"
set :deploy_to, "/www/weltel"
set :branch, "master"
set :shared_children, %w(system log pids sockets config)
set :sudo_user, ENV["USER"]

set :use_sudo, false
set :using_rvm, false
set :scm, :git
set :rake, "bundle exec rake"
set :deploy_via, :remote_cache

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
        sudo "RAILS_ENV=production god #{command.to_s} #{god_watch}"
      end
    end
  end
end

namespace :deploy do
	desc "Deletes deploy file"
	task :delete_deploy_file do
		run("rm -f #{shared_path}/deploy")
	end

	desc "Symlinks deploy file"
	task :symlink_deploy_file do
		run("ln -nfs #{deploy_to}/shared/deploy #{release_path}/config/database.yml")
	end

  desc "Uploads config"
  task :upload_config, :roles => :app do
  	top.upload("./config/config.yml", "#{shared_path}/config/config.yml")
    top.upload("./config/database.yml", "#{shared_path}/config/database.yml")
  end

  desc "Symlinks config"
  task :symlink_config, :roles => :app do
  	run("ln -nfs #{deploy_to}/shared/config/config.yml #{release_path}/config/config.yml")
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
    god.restart_all
  end
end

