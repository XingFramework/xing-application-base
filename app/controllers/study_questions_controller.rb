class StudyQuestionsController < ApplicationController
  before_action :set_study_question, only: [:show, :edit, :update, :destroy]

  # GET /study_questions
  # GET /study_questions.json
  def index
    @study_questions = StudyQuestion.all
  end

  # GET /study_questions/1
  # GET /study_questions/1.json
  def show
  end

  # GET /study_questions/new
  def new
    @study_question = StudyQuestion.new
  end

  # GET /study_questions/1/edit
  def edit
  end

  # POST /study_questions
  # POST /study_questions.json
  def create
    @study_question = StudyQuestion.new(study_question_params)

    respond_to do |format|
      if @study_question.save
        format.html { redirect_to @study_question, notice: 'Study question was successfully created.' }
        format.json { render :show, status: :created, location: @study_question }
      else
        format.html { render :new }
        format.json { render json: @study_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /study_questions/1
  # PATCH/PUT /study_questions/1.json
  def update
    respond_to do |format|
      if @study_question.update(study_question_params)
        format.html { redirect_to @study_question, notice: 'Study question was successfully updated.' }
        format.json { render :show, status: :ok, location: @study_question }
      else
        format.html { render :edit }
        format.json { render json: @study_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /study_questions/1
  # DELETE /study_questions/1.json
  def destroy
    @study_question.destroy
    respond_to do |format|
      format.html { redirect_to study_questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_study_question
      @study_question = StudyQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def study_question_params
      params.require(:study_question).permit(:text, :study_id, :attachment_file_name, :attachment_content_type, :attachment_file_size, :attachment_updated_at, :embed, :created_at, :updated_at)
    end
end
