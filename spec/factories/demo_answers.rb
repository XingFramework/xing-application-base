# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :demo_answer do
    text "MyString"
    position 1
    demo_question_id 1
    created_at "2014-04-14 15:18:01"
    updated_at "2014-04-14 15:18:01"
  end
end
