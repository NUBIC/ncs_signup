require 'bundler/capistrano'
require 'bcdatabase'

bcconf = Bcdatabase.load[:ncs_conf,:ncs_signup] # Using the bcdatabase gem for server config

set :application, "ncs_signup"

# User
set :use_sudo, false
ssh_options[:forward_agent] = true

# Version control
default_run_options[:pty]   = true # to get the passphrase prompt from git

default_environment['PATH'] = '/opt/ruby-enterprise/bin:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin'

set :scm, "git"
set :repository, bcconf["repo"]
set :branch do
  # http://nathanhoad.net/deploy-from-a-git-tag-with-capistrano
  puts
  puts "Tags: " + `git tag`.split("\n").join(", ")
  puts "Remember to push tags first: git push origin --tags"
  ref = Capistrano::CLI.ui.ask "Tag, branch, or commit to deploy [master]: "
  ref.empty? ? "master" : ref
end
set :deploy_to, bcconf["deploy_to"]
set :deploy_via, :remote_cache

# Roles
task :set_roles do
  role :app, app_server
  role :web, app_server
  role :db, app_server, :primary => true
end

# Staging environment
desc "Deploy to staging"
task :staging do
  set :app_server, bcconf["staging_app_server"]
  set :rails_env, "staging"
  set_roles
end

# Production environment
desc "Deploy to production"
task :production do
  set :app_server, bcconf["production_app_server"]
  set :rails_env, "production"
  set_roles
end

# Deploy start/stop/restart
namespace :deploy do
  desc "Restarting passenger with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  desc "Fix permissions"
  task :permissions do
    sudo "chmod -R g+w #{shared_path} #{current_path} #{release_path}"
  end
end

# backup the database before migrating
#before 'deploy:migrate', 'db:backup'

# after deploying, generate static pages, copy over uploads and results, cleanup old deploys, aggressively set permissions
after 'deploy:update_code', 'deploy:cleanup', 'deploy:permissions'

# Database
namespace :db do
  desc "Backup Database"
  task :backup,  :roles => :app do
    run "cd #{current_path} && rake RAILS_ENV=#{rails_env} db:backup"
  end
end
