class StudiesController < JsonController

  def index
    @studies = current_user.studies
    render json: @studies
  end

  # GET /studies/1
  def show
    #respond_with @study = @user.studies.where(:id => params[:id])
  end

  # POST /studies
  def create
    mapper = StudyMapper.new(request.body.read)
    mapper.save
    render json: @study
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_study
      @study = Study.find(params[:id])
    end

    #def study_params
      #params.require(:study).permit(:title, :notes, :quota, :duration, :start_at, :end_at, :gender_m, :gender_f, :age_from, :age_to, :researcher_id, :created_at, :updated_at, :status, :states, :countries, :regions, :internal_title, :seats_left, :admin, :token, :admin_fee, :application_fee, :pay_rate, :private, :logo_url, :token_secret, :language, :platform_web, :platform_ios, :platform_android, :pre_accepted_emails, :single_serve, :transcribe, :acceptance_email_copy, :acceptance_email_pdf)
    #end
end
