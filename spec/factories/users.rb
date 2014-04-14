# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "MyString"
    email "MyString"
    password "MyString"
    paypal_email "MyString"
    gender 1
    yob 1
    country "MyString"
    zip "MyString"
    time_zone "MyString"
    type ""
    rating_cache 1.5
    facebook_uid 1
    crypted_password "MyString"
    password_salt "MyString"
    persistence_token "MyString"
    perishable_token "MyString"
    single_access_token "MyString"
    login_count 1
    failed_login_count 1
    last_request_at "2014-04-14 15:20:54"
    current_login_at "2014-04-14 15:20:54"
    last_login_at "2014-04-14 15:20:54"
    current_login_ip "MyString"
    last_login_ip "MyString"
    public_token "MyString"
    created_at "2014-04-14 15:20:54"
    updated_at "2014-04-14 15:20:54"
    company "MyString"
    city "MyString"
    state "MyString"
    status 1
    phone "MyString"
    photo_file_name "MyString"
    photo_content_type "MyString"
    photo_file_size 1
    photo_updated_at "2014-04-14 15:20:54"
    last_name "MyString"
    mailer_setting 1
    dob "2014-04-14"
    blacklist false
    disable_email false
  end
end
