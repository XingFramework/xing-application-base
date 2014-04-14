class DemoResponsesController < ApplicationController
  before_action :set_demo_response, only: [:show, :edit, :update, :destroy]

  # GET /demo_responses
  # GET /demo_responses.json
  def index
    @demo_responses = DemoResponse.all
  end

  # GET /demo_responses/1
  # GET /demo_responses/1.json
  def show
  end

  # GET /demo_responses/new
  def new
    @demo_response = DemoResponse.new
  end

  # GET /demo_responses/1/edit
  def edit
  end

  # POST /demo_responses
  # POST /demo_responses.json
  def create
    @demo_response = DemoResponse.new(demo_response_params)

    respond_to do |format|
      if @demo_response.save
        format.html { redirect_to @demo_response, notice: 'Demo response was successfully created.' }
        format.json { render :show, status: :created, location: @demo_response }
      else
        format.html { render :new }
        format.json { render json: @demo_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /demo_responses/1
  # PATCH/PUT /demo_responses/1.json
  def update
    respond_to do |format|
      if @demo_response.update(demo_response_params)
        format.html { redirect_to @demo_response, notice: 'Demo response was successfully updated.' }
        format.json { render :show, status: :ok, location: @demo_response }
      else
        format.html { render :edit }
        format.json { render json: @demo_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /demo_responses/1
  # DELETE /demo_responses/1.json
  def destroy
    @demo_response.destroy
    respond_to do |format|
      format.html { redirect_to demo_responses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demo_response
      @demo_response = DemoResponse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def demo_response_params
      params.require(:demo_response).permit(:user_id, :demo_answer_id, :created_at, :updated_at)
    end
end
