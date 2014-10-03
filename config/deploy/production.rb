server 'www.uccf-losangeles.org', user: 'lrdesign', roles: %w{web app}
set :branch, "production"
set :application, "www.uccf-losangeles.org"

set :rails_warmup_url, 'http://www.uccf-losangeles.org/'
set :use_sudo, true
