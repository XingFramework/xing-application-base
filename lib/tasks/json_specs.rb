namespace :json_specs do
  task :update do
    rm_rf 'spec/fixtures/json/'
    cp_r 'angular/spec/fixtures/', 'spec/fixtures/json'
  end
end
