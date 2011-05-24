set :application, "heike_portfolio"
set :user, application
set :repository,  "git@github.com:allansideas/p_portfolio.git"
set :scm, :git

set :deploy_via, :remote_cache
set :use_sudo, false

ssh_options[:forward_agent] = true
default_run_options[:pty] = true 

task :production do
  set :deploy_to, "/home/#{application}/production"
  set :branch, "master"
  set :rails_env, 'production'
end

task :staging do
  set :deploy_to, "/home/#{application}/staging"
  set :branch, "master"
  set :rails_env, 'staging'
  role :app, "74.207.249.233"
  role :web, "74.207.249.233"
  role :db,  "74.207.249.233", :primary => true
end


namespace :deploy do
  # Using Phusion Passenger
  [:stop, :start, :restart].each do |task_name|
    task task_name, :roles => [:app] do
      run "cd #{current_path} && touch tmp/restart.txt"
    end 
  end 
  
  task :symlink_configs do
    run %( cd #{release_path} &&
      ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml
    )
  end 
  
  desc "bundle gems"
  task :bundle do
    run "cd #{release_path} && RAILS_ENV=#{rails_env} &&   bundle install --gemfile #{release_path}/Gemfile --path  #{shared_path}/bundle --deployment  --without development test"
  end
end

after "deploy:update_code" do
  deploy.symlink_configs
  deploy.bundle
end

require './config/boot'
