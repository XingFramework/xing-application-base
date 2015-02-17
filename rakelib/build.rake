namespace :build do
  task :all => %w{frontend:all}

  namespace :frontend do
    task :grunt_compile => ['frontend:setup'] do
      Bundler.with_clean_env do
        Dir.chdir("frontend"){ sh(*%w{bundle exec node_modules/.bin/grunt compile}) }
      end
    end

    task :all => [:grunt_compile]
  end
end
