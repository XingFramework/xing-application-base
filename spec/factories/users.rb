# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |nn| "user_#{nn}@example.com" }
    facebook_uid 1
    sign_in_count 20
    failed_attempts 0
    last_request_at "2014-04-14 15:20:54"
    current_sign_in_at "2014-04-14 15:20:54"
    last_sign_in_at "2014-04-14 15:20:54"
    current_sign_in_ip "10.0.0.1"
    last_sign_in_ip "10.0.0.1"
  end

  factory :consumer_user, :parent => :user do
    role_name 'Consumer'
    association :consumer_profile, :factory => :consumer
  end

  factory :researcher_user, :parent => :user do
    role_name 'Researcher'
    association :researcher_profile, :factory => :researcher
  end

  factory :admin_user, :parent => :user do
    role_name 'Admin'
  end
  factory :admin, :parent => :admin_user

  factory :consumer, :class => Profile::Consumer do
    first_name "John"
    last_name "Konsumer"
    paypal_email "john.paypal@example.com"
    phone "MyString"
    photo_file_name "MyString"
    photo_content_type "MyString"
    photo_file_size 1
    photo_updated_at "2014-04-14 15:20:54"
    city "MyString"
    state "MyString"
    date_of_birth { Date.today - 21.years }
    mailer_setting 1
    blacklist false
    disable_email false
    status 1
    gender 1
    country "MyString"
    zip "MyString"
    time_zone "MyString"
  end

  factory :researcher, :class => Profile::Researcher do
    first_name "Jane"
    last_name "Re.Searcher"
    company "Research Associates, Inc."
    status 1
  end
end
