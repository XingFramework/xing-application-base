# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :access_token do
    user_id 1
    email "MyString"
    token "MyString"
    created_at "2014-04-14 15:17:52"
    updated_at "2014-04-14 15:17:52"
    type ""
  end
end
