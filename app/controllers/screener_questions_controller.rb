class ScreenerQuestionsController < ApplicationController
  before_action :set_screener_question, only: [:show, :edit, :update, :destroy]

  # GET /screener_questions
  # GET /screener_questions.json
  def index
    @screener_questions = ScreenerQuestion.all
  end

  # GET /screener_questions/1
  # GET /screener_questions/1.json
  def show
  end

  # GET /screener_questions/new
  def new
    @screener_question = ScreenerQuestion.new
  end

  # GET /screener_questions/1/edit
  def edit
  end

  # POST /screener_questions
  # POST /screener_questions.json
  def create
    @screener_question = ScreenerQuestion.new(screener_question_params)

    respond_to do |format|
      if @screener_question.save
        format.html { redirect_to @screener_question, notice: 'Screener question was successfully created.' }
        format.json { render :show, status: :created, location: @screener_question }
      else
        format.html { render :new }
        format.json { render json: @screener_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /screener_questions/1
  # PATCH/PUT /screener_questions/1.json
  def update
    respond_to do |format|
      if @screener_question.update(screener_question_params)
        format.html { redirect_to @screener_question, notice: 'Screener question was successfully updated.' }
        format.json { render :show, status: :ok, location: @screener_question }
      else
        format.html { render :edit }
        format.json { render json: @screener_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /screener_questions/1
  # DELETE /screener_questions/1.json
  def destroy
    @screener_question.destroy
    respond_to do |format|
      format.html { redirect_to screener_questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_screener_question
      @screener_question = ScreenerQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def screener_question_params
      params.require(:screener_question).permit(:text, :options, :study_id, :created_at, :updated_at, :answer_type)
    end
end
