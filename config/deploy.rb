load "deploy/assets"

set :application, "pinkglasses.fr"
set :repository,  "git://github.com/prevostc/pinkglasses.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, "pinkglasses"
role :web, application                          # Your HTTP server, Apache/etc
role :app, application                          # This may be the same as your `Web` server
role :db,  application, :primary => true # This is where Rails migrations will run

set :use_sudo, false
set :deploy_to, "/var/www/#{application}"

set :default_environment, {
  'PATH'         => '/usr/local/rvm/bin:/usr/local/rvm/gems/ruby-1.9.3-p0/gems:$PATH',
  'RUBY_VERSION' => 'ruby 1.9.3',
  'GEM_HOME'     => '/usr/local/rvm/gems/ruby-1.9.3-p0',
  'GEM_PATH'     => '/usr/local/rvm/gems/ruby-1.9.3-p0:/usr/local/rvm/gems/ruby-1.9.3-p0@global',
  'BUNDLE_PATH'  => '/usr/local/rvm/gems/ruby-1.9.3-p0',  # If you are using bundler.
  'MY_RUBY_HOME' => '/usr/local/rvm/rubies/ruby-1.9.3-p0',
  'IRBRC'        => '/usr/local/rvm/rubies/ruby-1.9.3-p0/.irbrc',
}

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && rake db:migrate RAILS_ENV=\"production\" && cd -"
    run "unlink /var/www/pinkglasses.fr/current/db/production.sqlite3 || echo \"\""
    run "ln -s /var/www/pinkglasses.fr/shared/db.sqlite3 /var/www/pinkglasses.fr/current/db/production.sqlite3"
    run "unlink /var/www/pinkglasses.fr/current/public/images/glasses || echo \"\""
    run "ln -s /var/www/pinkglasses.fr/shared/pinkglasses_imgs /var/www/pinkglasses.fr/current/public/images/glasses"
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

