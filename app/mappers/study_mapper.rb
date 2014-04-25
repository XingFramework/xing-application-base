class StudyMapper

  def initialize(json)
    @source_json = json
    @source_hash = JSON.parse(json)
  end


  def save
    screener_questions = @source_hash.delete('screener_questions')
    researcher = User.find(@source_hash.delete('user_id'))
    @study = Study.new(@source_hash)
    @study.researcher = researcher
    screener_questions.each do |sq_hash|
      @study.screener_questions.build(sq_hash)
    end
    @study.save
    @study
  end
end
