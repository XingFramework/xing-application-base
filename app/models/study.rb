class Study < ActiveRecord::Base
  has_many   :screener_questions
  belongs_to :user
end
