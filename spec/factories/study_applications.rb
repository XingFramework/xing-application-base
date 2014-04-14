# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :study_application do
    study_id 1
    consumer_id 1
    segment_id 1
    status 1
    accepted_or_declined_at "2014-04-14 15:18:19"
    started_at "2014-04-14 15:18:19"
    completed_at "2014-04-14 15:18:19"
    payed_at "2014-04-14 15:18:19"
    disputed_at "2014-04-14 15:18:19"
    dispute_reason "MyText"
    created_at "2014-04-14 15:18:19"
    updated_at "2014-04-14 15:18:19"
    inviter_id 1
    applied_at "2014-04-14 15:18:19"
    referrer_id 1
    refute_reason "MyString"
    refuted_at "2014-04-14 15:18:19"
    referral_email "MyString"
    token "MyString"
    notified_full_at "2014-04-14 15:18:19"
  end
end
