class StudyAnswersController < ApplicationController
  before_action :set_study_answer, only: [:show, :edit, :update, :destroy]

  # GET /study_answers
  # GET /study_answers.json
  def index
    @study_answers = StudyAnswer.all
  end

  # GET /study_answers/1
  # GET /study_answers/1.json
  def show
  end

  # GET /study_answers/new
  def new
    @study_answer = StudyAnswer.new
  end

  # GET /study_answers/1/edit
  def edit
  end

  # POST /study_answers
  # POST /study_answers.json
  def create
    @study_answer = StudyAnswer.new(study_answer_params)

    respond_to do |format|
      if @study_answer.save
        format.html { redirect_to @study_answer, notice: 'Study answer was successfully created.' }
        format.json { render :show, status: :created, location: @study_answer }
      else
        format.html { render :new }
        format.json { render json: @study_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /study_answers/1
  # PATCH/PUT /study_answers/1.json
  def update
    respond_to do |format|
      if @study_answer.update(study_answer_params)
        format.html { redirect_to @study_answer, notice: 'Study answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @study_answer }
      else
        format.html { render :edit }
        format.json { render json: @study_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /study_answers/1
  # DELETE /study_answers/1.json
  def destroy
    @study_answer.destroy
    respond_to do |format|
      format.html { redirect_to study_answers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_study_answer
      @study_answer = StudyAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def study_answer_params
      params.require(:study_answer).permit(:study_question_id, :study_application_id, :created_at, :updated_at, :latitude, :longitude)
    end
end
