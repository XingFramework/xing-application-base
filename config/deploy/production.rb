server 'appserver2.lrdesign.com', user: 'root', roles: %w{web app}
set :branch, "production"
set :application, "uccf-losangeles.org"



set :rails_warmup_url, 'http://www.uccf-losangeles.org/'
