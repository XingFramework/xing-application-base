# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :screener_answer do
    text "MyText"
    study_application_id 1
    screener_question_id 1
    rating 1
    created_at "2014-04-14 15:18:10"
    updated_at "2014-04-14 15:18:10"
  end
end
