class StudiesController < JsonController
  before_action :set_user

  def index
    @studies = @user.studies
    render json: @studies
  end

  # GET /studies/1
  def show
    #respond_with @study = @user.studies.where(:id => params[:id])
  end

  # POST /studies
  def create
    #@study = Study.new(study_params)

      #if @study.save
        #format.json { render :show, status: :created, location: @study }
      #else
        #format.json { render json: @study.errors, status: :unprocessable_entity }
      #end
    #end
  end

  private
    def set_user
      @user = User.find(params[:owner])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_study
      @study = Study.find(params[:id])
    end

    #def study_params
      #params.require(:study).permit(:title, :notes, :quota, :duration, :start_at, :end_at, :gender_m, :gender_f, :age_from, :age_to, :researcher_id, :created_at, :updated_at, :status, :states, :countries, :regions, :internal_title, :seats_left, :admin, :token, :admin_fee, :application_fee, :pay_rate, :private, :logo_url, :token_secret, :language, :platform_web, :platform_ios, :platform_android, :pre_accepted_emails, :single_serve, :transcribe, :acceptance_email_copy, :acceptance_email_pdf)
    #end
end
