# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :screener_question do
    text "What is your favorite color?"
    options { [ 'Red', 'Green', 'Blue' ] }
  end

  factory :screener_question_single, :parent => :screener_question do
    answer_type { ScreenerQuestion::TYPE_SINGLE }
  end

  factory :screener_question_multiple, :parent => :screener_question do
    text "Which colors do you like?"
    answer_type { ScreenerQuestion::TYPE_MULTIPLE }
  end

  factory :screener_question_open, :parent => :screener_question do
    text "Tell me about your favorite color"
    answer_type { ScreenerQuestion::TYPE_OPEN }
  end
end
