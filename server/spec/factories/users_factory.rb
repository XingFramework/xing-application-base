FactoryGirl.define do
  factory :user do
    sequence :login do |n| "username #{n}" end
    password 'password'
    password_confirmation 'password'
  end
end
