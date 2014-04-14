class DemoAnswersController < ApplicationController
  before_action :set_demo_answer, only: [:show, :edit, :update, :destroy]

  # GET /demo_answers
  # GET /demo_answers.json
  def index
    @demo_answers = DemoAnswer.all
  end

  # GET /demo_answers/1
  # GET /demo_answers/1.json
  def show
  end

  # GET /demo_answers/new
  def new
    @demo_answer = DemoAnswer.new
  end

  # GET /demo_answers/1/edit
  def edit
  end

  # POST /demo_answers
  # POST /demo_answers.json
  def create
    @demo_answer = DemoAnswer.new(demo_answer_params)

    respond_to do |format|
      if @demo_answer.save
        format.html { redirect_to @demo_answer, notice: 'Demo answer was successfully created.' }
        format.json { render :show, status: :created, location: @demo_answer }
      else
        format.html { render :new }
        format.json { render json: @demo_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /demo_answers/1
  # PATCH/PUT /demo_answers/1.json
  def update
    respond_to do |format|
      if @demo_answer.update(demo_answer_params)
        format.html { redirect_to @demo_answer, notice: 'Demo answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @demo_answer }
      else
        format.html { render :edit }
        format.json { render json: @demo_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /demo_answers/1
  # DELETE /demo_answers/1.json
  def destroy
    @demo_answer.destroy
    respond_to do |format|
      format.html { redirect_to demo_answers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demo_answer
      @demo_answer = DemoAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def demo_answer_params
      params.require(:demo_answer).permit(:text, :position, :demo_question_id, :created_at, :updated_at)
    end
end
