set :application,   "movienight"
set :rumble_server, "movienight.r10.railsrumble.com"
set :repository,    "git@github.com:railsrumble/rr10-team-235.git"
set :use_sudo,      false
set :deploy_via,    :remote_cache
set :deploy_to,     "/data/web/#{application}"
set :scm,           "git"
set :user,          "root"

role :app, rumble_server
role :web, rumble_server
role :db,  rumble_server, :primary => true

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

namespace :bundler do
  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end
 
  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && bundle install --without test"
  end
end

namespace :configs do
  task :create_symlinks, :roles => :app do
    shared_dir = File.join(shared_path, 'config')
    run("cd #{current_release}/config && ln -s #{shared_dir}/pusher.yml")
  end
end
 
after 'deploy:update_code', 'bundler:bundle_new_release'
after 'deploy:update_code', 'configs:create_symlinks'
