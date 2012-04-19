namespace :unicorn do
  [:start, :stop, :restart].each do |command|
    desc "#{command.to_s.capitalize} unicorn"
    task command, :roles => :app , :except => { :no_release => true } do
      run "cd #{current_path} && RAILS_ENV=production script/unicorn #{command.to_s}"
    end
  end
end