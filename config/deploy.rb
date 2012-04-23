require "bundler/capistrano"

set :application, "weltel"

set :using_rvm, false

set :scm, :git
set :repository,  "ssh://git@dev.verticallabs.ca/git/mambo/apps/weltel.git"
set :branch, "master"
set :deploy_via, :remote_cache

set :rake, "bundle exec rake"

set :shared_children, %w(system log pids sockets config)

set :sudo_user, ENV["USER"]
set :use_sudo, false

set :deploy_to, "/www/weltel"

task :local do
	role :web, "localhost"
	role :app, "localhost"
	role :db, "localhost", :primary => true

	set :normal_user, "cdion"
	set :user, normal_user

	after "deploy:setup", "deploy:upload_config"
	after "deploy:update_code", "deploy:symlink_config"
	after "deploy:symlink_config", "deploy:migrate"
	after "deploy:restart", "deploy:delete_deploy_file"
end

task :staging do
	role :web, "dev.verticallabs.ca"
	role :app, "dev.verticallabs.ca"
	role :db, "dev.verticallabs.ca", :primary => true

	set :normal_user, "web"
	set :user, normal_user

	after "deploy:setup", "deploy:upload_config"
	after "deploy:update_code", "deploy:symlink_config"
	after "deploy:symlink_config", "deploy:migrate"
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
    top.upload("./config/database.yml", "#{shared_path}/config/database.yml")
  end

  desc "Symlinks config"
  task :symlink_config, :roles => :app do
    run("ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml")
  end
end
