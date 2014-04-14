# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    what_id 1
    what_type "MyString"
    amount 1
    note "MyText"
    created_at "2014-04-14 15:18:29"
    updated_at "2014-04-14 15:18:29"
    user_id 1
    payment_method "MyString"
    reference "MyString"
    authorization "MyString"
    study_id 1
    category 1
  end
end
