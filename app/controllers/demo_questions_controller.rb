class DemoQuestionsController < ApplicationController
  before_action :set_demo_question, only: [:show, :edit, :update, :destroy]

  # GET /demo_questions
  # GET /demo_questions.json
  def index
    @demo_questions = DemoQuestion.all
  end

  # GET /demo_questions/1
  # GET /demo_questions/1.json
  def show
  end

  # GET /demo_questions/new
  def new
    @demo_question = DemoQuestion.new
  end

  # GET /demo_questions/1/edit
  def edit
  end

  # POST /demo_questions
  # POST /demo_questions.json
  def create
    @demo_question = DemoQuestion.new(demo_question_params)

    respond_to do |format|
      if @demo_question.save
        format.html { redirect_to @demo_question, notice: 'Demo question was successfully created.' }
        format.json { render :show, status: :created, location: @demo_question }
      else
        format.html { render :new }
        format.json { render json: @demo_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /demo_questions/1
  # PATCH/PUT /demo_questions/1.json
  def update
    respond_to do |format|
      if @demo_question.update(demo_question_params)
        format.html { redirect_to @demo_question, notice: 'Demo question was successfully updated.' }
        format.json { render :show, status: :ok, location: @demo_question }
      else
        format.html { render :edit }
        format.json { render json: @demo_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /demo_questions/1
  # DELETE /demo_questions/1.json
  def destroy
    @demo_question.destroy
    respond_to do |format|
      format.html { redirect_to demo_questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demo_question
      @demo_question = DemoQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def demo_question_params
      params.require(:demo_question).permit(:text, :caption, :position, :multiple, :created_at, :updated_at)
    end
end
