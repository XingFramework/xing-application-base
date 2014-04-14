# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :screener_question do
    text "MyText"
    options "MyText"
    study_id 1
    created_at "2014-04-14 15:18:12"
    updated_at "2014-04-14 15:18:12"
    answer_type 1
  end
end
