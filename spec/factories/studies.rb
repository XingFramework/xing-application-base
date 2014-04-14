# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :study, :class => 'Studie' do
    title "MyString"
    notes "MyText"
    quota 1
    duration 1
    start_at "2014-04-14 15:18:16"
    end_at "2014-04-14 15:18:16"
    gender_m false
    gender_f false
    age_from 1
    age_to 1
    researcher_id 1
    created_at "2014-04-14 15:18:16"
    updated_at "2014-04-14 15:18:16"
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
