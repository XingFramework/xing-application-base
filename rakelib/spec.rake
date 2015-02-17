namespace :spec do

  task :grunt_ci_test => 'build:frontend:all' do
    Bundler.with_clean_env do
      Dir.chdir("frontend"){
        sh *%w{bundle exec node_modules/.bin/grunt ci-test}
      }
    end
  end

  task :full, [:spec_files] => [:check_dependencies, :grunt_ci_test, 'backend:setup'] do |t, args|
    Bundler.with_clean_env do
      Dir.chdir("backend"){
        commands = %w{bundle exec rspec}
        if args[:spec_files]
          commands.push(args[:spec_files])
        end
        sh *commands
      }
    end
  end

  desc "Run all feature specs, repeating with each browser width as default"
  task :responsivity, [:spec_files] => ['backend:setup'] do |t, args|
    Bundler.with_clean_env do
      %w{mobile small medium desktop}.each do |size|
        Dir.chdir("backend"){
          ENV['BROWSER_SIZE']=size
          commands = ["bundle", "exec", "rspec", "-o", "tmp/rspec_#{size}.txt"]
          if args[:spec_files]
            commands.push(args[:spec_files])
          else
            commands.push('spec/features')
          end
          sh *commands rescue true
        }
      end
    end
  end

  task :fast, [:spec_files] => ['backend:setup'] do |t, args|
    Bundler.with_clean_env do
      Dir.chdir("backend"){
        commands = %w{bundle exec rspec}
        if args[:spec_files]
          commands.push(args[:spec_files])
        else
          commands.push("--tag").push("~type:feature")
        end
        sh *commands
      }
    end
  end
end
