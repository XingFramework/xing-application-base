class Study < ActiveRecord::Base
  has_many   :screener_questions
  belongs_to :researcher, :class_name => User

end
