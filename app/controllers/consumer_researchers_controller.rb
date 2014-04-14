class ConsumerResearchersController < ApplicationController
  before_action :set_consumer_researcher, only: [:show, :edit, :update, :destroy]

  # GET /consumer_researchers
  # GET /consumer_researchers.json
  def index
    @consumer_researchers = ConsumerResearcher.all
  end

  # GET /consumer_researchers/1
  # GET /consumer_researchers/1.json
  def show
  end

  # GET /consumer_researchers/new
  def new
    @consumer_researcher = ConsumerResearcher.new
  end

  # GET /consumer_researchers/1/edit
  def edit
  end

  # POST /consumer_researchers
  # POST /consumer_researchers.json
  def create
    @consumer_researcher = ConsumerResearcher.new(consumer_researcher_params)

    respond_to do |format|
      if @consumer_researcher.save
        format.html { redirect_to @consumer_researcher, notice: 'Consumer researcher was successfully created.' }
        format.json { render :show, status: :created, location: @consumer_researcher }
      else
        format.html { render :new }
        format.json { render json: @consumer_researcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consumer_researchers/1
  # PATCH/PUT /consumer_researchers/1.json
  def update
    respond_to do |format|
      if @consumer_researcher.update(consumer_researcher_params)
        format.html { redirect_to @consumer_researcher, notice: 'Consumer researcher was successfully updated.' }
        format.json { render :show, status: :ok, location: @consumer_researcher }
      else
        format.html { render :edit }
        format.json { render json: @consumer_researcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consumer_researchers/1
  # DELETE /consumer_researchers/1.json
  def destroy
    @consumer_researcher.destroy
    respond_to do |format|
      format.html { redirect_to consumer_researchers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consumer_researcher
      @consumer_researcher = ConsumerResearcher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consumer_researcher_params
      params.require(:consumer_researcher).permit(:consumer_id, :researcher_id, :created_at, :updated_at)
    end
end
