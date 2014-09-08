FactoryGirl.define do
  factory :user do
    sequence :login do |n| "username #{n}" end
    password 'password'
    password_confirmation 'password'
  end

  trait :admin do
    role_name 'admin'
  end
end
