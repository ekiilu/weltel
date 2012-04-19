namespace :deploy do
  desc <<-DESC
		Starts server
  DESC
  task :start, :roles => :app do
    unicorn.start
  end

  desc <<-DESC
		Stops server
  DESC
  task :stop, :roles => :app do
    unicorn.stop
  end

  desc <<-DESC
		Restarts server
  DESC
  task :restart, :roles => :app, :except => { :no_release => true } do
    unicorn.restart
  end
end