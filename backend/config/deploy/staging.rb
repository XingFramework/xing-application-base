set :user, 'root'
set :domain, 'appserver.lrdesign.com'
set :applicationdir, "/var/www/staging.some-cms-site.com"
set :deploy_to, applicationdir
set :keep_releases, 5
set :branch, 'staging'

set :rails_env, "staging"
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false
