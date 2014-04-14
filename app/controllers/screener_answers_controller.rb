class ScreenerAnswersController < ApplicationController
  before_action :set_screener_answer, only: [:show, :edit, :update, :destroy]

  # GET /screener_answers
  # GET /screener_answers.json
  def index
    @screener_answers = ScreenerAnswer.all
  end

  # GET /screener_answers/1
  # GET /screener_answers/1.json
  def show
  end

  # GET /screener_answers/new
  def new
    @screener_answer = ScreenerAnswer.new
  end

  # GET /screener_answers/1/edit
  def edit
  end

  # POST /screener_answers
  # POST /screener_answers.json
  def create
    @screener_answer = ScreenerAnswer.new(screener_answer_params)

    respond_to do |format|
      if @screener_answer.save
        format.html { redirect_to @screener_answer, notice: 'Screener answer was successfully created.' }
        format.json { render :show, status: :created, location: @screener_answer }
      else
        format.html { render :new }
        format.json { render json: @screener_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /screener_answers/1
  # PATCH/PUT /screener_answers/1.json
  def update
    respond_to do |format|
      if @screener_answer.update(screener_answer_params)
        format.html { redirect_to @screener_answer, notice: 'Screener answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @screener_answer }
      else
        format.html { render :edit }
        format.json { render json: @screener_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /screener_answers/1
  # DELETE /screener_answers/1.json
  def destroy
    @screener_answer.destroy
    respond_to do |format|
      format.html { redirect_to screener_answers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_screener_answer
      @screener_answer = ScreenerAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def screener_answer_params
      params.require(:screener_answer).permit(:text, :study_application_id, :screener_question_id, :rating, :created_at, :updated_at)
    end
end
