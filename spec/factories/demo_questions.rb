# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :demo_question do
    text "MyString"
    caption "MyString"
    position 1
    multiple false
    created_at "2014-04-14 15:18:03"
    updated_at "2014-04-14 15:18:03"
  end
end
