# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tagging do
    tag_id 1
    taggable_id 1
    taggable_type "MyString"
    tagger_id 1
    tagger_type "MyString"
    context "MyString"
    created_at "2014-04-14 15:18:25"
  end
end
