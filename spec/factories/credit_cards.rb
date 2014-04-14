# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :credit_card do
    researcher_id 1
    first_name "MyString"
    last_name "MyString"
    number "MyString"
    month "MyString"
    year "MyString"
    ctype "MyString"
    cvv "MyString"
    address1 "MyString"
    address2 "MyString"
    city "MyString"
    state "MyString"
    country "MyString"
    zip "MyString"
    created_at "2014-04-14 15:17:58"
    updated_at "2014-04-14 15:17:58"
    reference_transaction "MyString"
  end
end
