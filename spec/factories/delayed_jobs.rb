# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :delayed_job do
    priority 1
    attempts 1
    handler "MyText"
    last_error "MyText"
    run_at "2014-04-14 15:17:59"
    locked_at "2014-04-14 15:17:59"
    failed_at "2014-04-14 15:17:59"
    locked_by "MyString"
    created_at "2014-04-14 15:17:59"
    updated_at "2014-04-14 15:17:59"
    queue "MyString"
  end
end
