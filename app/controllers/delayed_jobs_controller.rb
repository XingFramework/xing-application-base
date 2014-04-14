class DelayedJobsController < ApplicationController
  before_action :set_delayed_job, only: [:show, :edit, :update, :destroy]

  # GET /delayed_jobs
  # GET /delayed_jobs.json
  def index
    @delayed_jobs = DelayedJob.all
  end

  # GET /delayed_jobs/1
  # GET /delayed_jobs/1.json
  def show
  end

  # GET /delayed_jobs/new
  def new
    @delayed_job = DelayedJob.new
  end

  # GET /delayed_jobs/1/edit
  def edit
  end

  # POST /delayed_jobs
  # POST /delayed_jobs.json
  def create
    @delayed_job = DelayedJob.new(delayed_job_params)

    respond_to do |format|
      if @delayed_job.save
        format.html { redirect_to @delayed_job, notice: 'Delayed job was successfully created.' }
        format.json { render :show, status: :created, location: @delayed_job }
      else
        format.html { render :new }
        format.json { render json: @delayed_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delayed_jobs/1
  # PATCH/PUT /delayed_jobs/1.json
  def update
    respond_to do |format|
      if @delayed_job.update(delayed_job_params)
        format.html { redirect_to @delayed_job, notice: 'Delayed job was successfully updated.' }
        format.json { render :show, status: :ok, location: @delayed_job }
      else
        format.html { render :edit }
        format.json { render json: @delayed_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delayed_jobs/1
  # DELETE /delayed_jobs/1.json
  def destroy
    @delayed_job.destroy
    respond_to do |format|
      format.html { redirect_to delayed_jobs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delayed_job
      @delayed_job = DelayedJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delayed_job_params
      params.require(:delayed_job).permit(:priority, :attempts, :handler, :last_error, :run_at, :locked_at, :failed_at, :locked_by, :created_at, :updated_at, :queue)
    end
end
