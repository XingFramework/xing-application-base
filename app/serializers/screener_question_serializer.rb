class ScreenerQuestionSerializer < ActiveModel::Serializer
  attributes :text, :answer_type,  :options

  def options
    object.options
  end
end
