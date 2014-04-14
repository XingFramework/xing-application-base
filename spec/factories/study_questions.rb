# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :study_question do
    text "MyText"
    study_id 1
    attachment_file_name "MyString"
    attachment_content_type "MyString"
    attachment_file_size 1
    attachment_updated_at "2014-04-14 15:18:21"
    embed "MyText"
    created_at "2014-04-14 15:18:21"
    updated_at "2014-04-14 15:18:21"
  end
end
