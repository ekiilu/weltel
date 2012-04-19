require 'bundler/capistrano'

set :sudo_user, ENV['USER']
set :application, 'weltel'
set :repository,  "ssh://git@dev.verticallabs.ca/git/weltel.git"
set :scm, :git
set :using_rvm, false
set :deploy_via, :remote_cache
set :rake, 'bundle exec rake'
set :shared_children, %w(system log pids sockets config)

role :web, 'localhost'
role :app, 'localhost'
role :db, 'localhost', :primary => true

set :normal_user, 'cdion'
set :user, normal_user
set :use_sudo, false

set :deploy_to, "/www/weltel"

set :branch, 'ltbi'

after 'deploy:restart', 'deploy:delete_deploy_file'

after 'deploy:setup', 'deploy:upload_config'
after 'deploy:update_code', 'deploy:symlink_config'
after 'deploy:symlink_config', 'deploy:migrate'

namespace :deploy do
	desc 'Create deploy file'
	task :create_deploy_file do
		run("touch #{shared_path}/deploy")
	end

	desc 'Delete deploy file'
	task :delete_deploy_file do
		run("rm -f #{shared_path}/deploy")
	end

	desc 'Symlink deploy file'
	task :symlink_deploy_file do
		run("ln -nfs #{deploy_to}/shared/deploy #{release_path}/config/database.yml")
	end

  desc 'Uploads config'
  task :upload_config, :roles => :app do
    top.upload('./config/database.yml', "#{shared_path}/config/database.yml")
  end

  desc "Symlinks config"
  task :symlink_config, :roles => :app do
    run("ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml")
  end
end
