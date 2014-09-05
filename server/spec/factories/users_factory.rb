FactoryGirl.define do

  factory :user do
    sequence :login do |n| "username #{n}" end
    sequence(:email) { |nn| "user_#{nn}@example.com" }
    password 'password'
    password_confirmation 'password'
    #facebook_uid 1
    sign_in_count 20
    failed_attempts 0
    last_request_at "2014-04-14 15:20:54"
    current_sign_in_at "2014-04-14 15:20:54"
    last_sign_in_at "2014-04-14 15:20:54"
    current_sign_in_ip "10.0.0.1"
    last_sign_in_ip "10.0.0.1"
  end

  factory :admin_user, :parent => :user do
    role_name 'Admin'
  end
  factory :admin, :parent => :admin_user

end
