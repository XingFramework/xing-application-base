class StudyApplicationsController < ApplicationController
  before_action :set_study_application, only: [:show, :edit, :update, :destroy]

  # GET /study_applications
  # GET /study_applications.json
  def index
    @study_applications = StudyApplication.all
  end

  # GET /study_applications/1
  # GET /study_applications/1.json
  def show
  end

  # GET /study_applications/new
  def new
    @study_application = StudyApplication.new
  end

  # GET /study_applications/1/edit
  def edit
  end

  # POST /study_applications
  # POST /study_applications.json
  def create
    @study_application = StudyApplication.new(study_application_params)

    respond_to do |format|
      if @study_application.save
        format.html { redirect_to @study_application, notice: 'Study application was successfully created.' }
        format.json { render :show, status: :created, location: @study_application }
      else
        format.html { render :new }
        format.json { render json: @study_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /study_applications/1
  # PATCH/PUT /study_applications/1.json
  def update
    respond_to do |format|
      if @study_application.update(study_application_params)
        format.html { redirect_to @study_application, notice: 'Study application was successfully updated.' }
        format.json { render :show, status: :ok, location: @study_application }
      else
        format.html { render :edit }
        format.json { render json: @study_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /study_applications/1
  # DELETE /study_applications/1.json
  def destroy
    @study_application.destroy
    respond_to do |format|
      format.html { redirect_to study_applications_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_study_application
      @study_application = StudyApplication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def study_application_params
      params.require(:study_application).permit(:study_id, :consumer_id, :segment_id, :status, :accepted_or_declined_at, :started_at, :completed_at, :payed_at, :disputed_at, :dispute_reason, :created_at, :updated_at, :inviter_id, :applied_at, :referrer_id, :refute_reason, :refuted_at, :referral_email, :token, :notified_full_at)
    end
end
