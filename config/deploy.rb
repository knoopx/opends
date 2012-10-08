require 'capistrano_colors'
require 'bundler/capistrano'

set :application, "OpenDS"
set :keep_releases, 5
set :bundle_without, [:development, :test]

set :scm, :git
set :deploy_via, :remote_cache
set :repository, "git://github.com/knoopx/opends.git"

#set :user, 'deploy'
set :use_sudo, false
set :deploy_to, '~/opends'
set :normalize_asset_timestamps, false

set :rvm_ruby_string, "1.9.3"
set :rvm_type, :system
set :rvm_install_with_sudo, true

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy:restart", "deploy:cleanup"
after 'deploy:update_code', 'deploy:symlink_config'

server "192.168.1.77", :web, :app, :db

set(:thin_command) { 'bundle exec thin' }
set(:thin_config) { "-d -P tmp/pids/thin.pid -e production -p 5000" }

namespace :deploy do
  task :start do
    run "cd #{current_path} && #{thin_command} #{thin_config} start"
  end

  task :stop do
    run "cd #{current_path} && #{thin_command} #{thin_config} stop"
  end

  task :restart do
    run "cd #{current_path} && #{thin_command} #{thin_config} -O restart"
  end

  desc "Symlink shared configs and folders on each release."
  task :symlink_config do
    run "ln -nfs #{shared_path}/initializers/opends.rb #{release_path}/config/initializers/opends.rb"
  end
end