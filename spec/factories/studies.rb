# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :study  do
    title "Cool New Study"
    notes "Notes on how the study works"
    quota 20
    duration 10
    start_at { (Time.now + 5.days).beginning_of_day }
    end_at { (Time.now + 15.days).end_of_day }
    gender_m true
    gender_f true
    age_from 1
    age_to 1
    researcher_id 1
    status 1
    states "MyText"
    countries "MyText"
    regions "MyText"
    internal_title "MyString"
    seats_left 1
    admin false
    token "MyString"
    admin_fee 1
    application_fee 1
    pay_rate 1
    private false
    logo_url "MyString"
    token_secret "MyString"
    language "MyString"
    platform_web false
    platform_ios false
    platform_android false
    pre_accepted_emails "MyText"
    single_serve false
    transcribe false
    acceptance_email_copy "MyText"
    acceptance_email_pdf "MyString"
  end
end
