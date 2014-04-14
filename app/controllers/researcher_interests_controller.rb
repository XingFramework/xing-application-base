class ResearcherInterestsController < ApplicationController
  before_action :set_researcher_interest, only: [:show, :edit, :update, :destroy]

  # GET /researcher_interests
  # GET /researcher_interests.json
  def index
    @researcher_interests = ResearcherInterest.all
  end

  # GET /researcher_interests/1
  # GET /researcher_interests/1.json
  def show
  end

  # GET /researcher_interests/new
  def new
    @researcher_interest = ResearcherInterest.new
  end

  # GET /researcher_interests/1/edit
  def edit
  end

  # POST /researcher_interests
  # POST /researcher_interests.json
  def create
    @researcher_interest = ResearcherInterest.new(researcher_interest_params)

    respond_to do |format|
      if @researcher_interest.save
        format.html { redirect_to @researcher_interest, notice: 'Researcher interest was successfully created.' }
        format.json { render :show, status: :created, location: @researcher_interest }
      else
        format.html { render :new }
        format.json { render json: @researcher_interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /researcher_interests/1
  # PATCH/PUT /researcher_interests/1.json
  def update
    respond_to do |format|
      if @researcher_interest.update(researcher_interest_params)
        format.html { redirect_to @researcher_interest, notice: 'Researcher interest was successfully updated.' }
        format.json { render :show, status: :ok, location: @researcher_interest }
      else
        format.html { render :edit }
        format.json { render json: @researcher_interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /researcher_interests/1
  # DELETE /researcher_interests/1.json
  def destroy
    @researcher_interest.destroy
    respond_to do |format|
      format.html { redirect_to researcher_interests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_researcher_interest
      @researcher_interest = ResearcherInterest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def researcher_interest_params
      params.require(:researcher_interest).permit(:first_name, :last_name, :email, :phone, :company_name, :created_at, :updated_at)
    end
end
