namespace :json_specs do
  desc "Copy authoritative specs to spec/fixtures"
  task :update do
    rm_rf 'spec/fixtures/json/'
    cp_r 'angular/spec/fixtures/', 'spec/fixtures/json'
  end
end
