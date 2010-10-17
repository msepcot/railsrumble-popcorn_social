set :application,   "movienight"
set :rumble_server, "movienight.r10.railsrumble.com"
set :repository,    "git@github.com:railsrumble/rr10-team-235.git"
set :use_sudo,      false
set :deploy_via,    :remote_cache
set :deploy_to,     "/data/web/#{application}"
set :scm,           "git"
set :user,          "grumbler"

role :app, rumble_server
role :web, rumble_server
role :db,  rumble_server, :primary => true

namespace :solr do
  desc "Start solr"
  task :start, :roles => :app do
    run "cd #{current_release} && RAILS_ENV=production rake sunspot:solr:start"
  end

  desc "Stop solr"
  task :stop, :roles => :app do
    run "cd #{current_release} && RAILS_ENV=production rake sunspot:solr:stop"
  end

  desc "Index solr"
  task :reindex, :roles => :app do
    run "cd #{current_release} && RAILS_ENV=production rake sunspot:solr:reindex"
  end
end


namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # nada
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
    run "cd #{release_path} && ( bundle check || bundle install --without test ) "
  end
end

namespace :configs do
  task :create_symlinks, :roles => :app do
    shared_dir = File.join(shared_path, 'config')
    run("cd #{current_release}/config && ln -s #{shared_dir}/pusher.yml")
    run("cd #{current_release}/config && ln -s #{shared_dir}/twit.yml")
  end
end
 
namespace :talk do
  task :update_twitter, :roles => :app do
    messages = [
      "I just pushed a build, what're you doin'?",
      "Deployment time.  Why do I smell fire?",
      "Just launched some bugs, shouldn't you help me find them?",
      "Code push!",
      "Don't kick the plug.  This last build is the one!",
      "Just pushed some code, please help test",
      "Come check out MovieNight we just updated!"
    ]

    begin
      require 'twitter'
      twit = YAML.load_file('config/twit.yml')
      auth = Twitter::OAuth.new(twit['consumer_key'], twit['consumer_secret'])
      auth.authorize_from_access(twit['access_token'], twit['access_secret'])
      client = Twitter::Base.new(auth)
      client.update messages.shuffle.first
    rescue
      # meh
    end
  end
end

after 'deploy:update_code', 'bundler:bundle_new_release'
after 'deploy:update_code', 'configs:create_symlinks'

after 'deploy:restart', 'talk:update_twitter'
