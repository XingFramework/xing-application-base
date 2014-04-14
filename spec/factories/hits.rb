# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hit do
    user_id 1
    ip "MyString"
    request "MyText"
    params "MyText"
    created_at "2014-04-14 15:18:06"
    updated_at "2014-04-14 15:18:06"
  end
end
