# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :study_answer do
    study_question_id 1
    study_application_id 1
    created_at "2014-04-14 15:18:17"
    updated_at "2014-04-14 15:18:17"
    latitude 1.5
    longitude 1.5
  end
end
