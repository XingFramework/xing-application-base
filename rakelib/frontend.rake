namespace :frontend do
  task :npm_install do
    Dir.chdir("frontend"){ sh *%w{npm install} }
  end

  task :bundle_install do
    Dir.chdir("frontend"){ sh *%w{bundle install} }
  end

  task :check_dependencies => :npm_install

  task :setup => [:npm_install, :bundle_install]
end
