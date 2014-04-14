class StudiesController < ApplicationController
  before_action :set_study, only: [:show, :edit, :update, :destroy]

  # GET /studies
  # GET /studies.json
  def index
    @studies = Studie.all
  end

  # GET /studies/1
  # GET /studies/1.json
  def show
  end

  # GET /studies/new
  def new
    @study = Studie.new
  end

  # GET /studies/1/edit
  def edit
  end

  # POST /studies
  # POST /studies.json
  def create
    @study = Studie.new(study_params)

    respond_to do |format|
      if @study.save
        format.html { redirect_to @study, notice: 'Studie was successfully created.' }
        format.json { render :show, status: :created, location: @study }
      else
        format.html { render :new }
        format.json { render json: @study.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /studies/1
  # PATCH/PUT /studies/1.json
  def update
    respond_to do |format|
      if @study.update(study_params)
        format.html { redirect_to @study, notice: 'Studie was successfully updated.' }
        format.json { render :show, status: :ok, location: @study }
      else
        format.html { render :edit }
        format.json { render json: @study.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /studies/1
  # DELETE /studies/1.json
  def destroy
    @study.destroy
    respond_to do |format|
      format.html { redirect_to studies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_study
      @study = Studie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def study_params
      params.require(:study).permit(:title, :notes, :quota, :duration, :start_at, :end_at, :gender_m, :gender_f, :age_from, :age_to, :researcher_id, :created_at, :updated_at, :status, :states, :countries, :regions, :internal_title, :seats_left, :admin, :token, :admin_fee, :application_fee, :pay_rate, :private, :logo_url, :token_secret, :language, :platform_web, :platform_ios, :platform_android, :pre_accepted_emails, :single_serve, :transcribe, :acceptance_email_copy, :acceptance_email_pdf)
    end
end
