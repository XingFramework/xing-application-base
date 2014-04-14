class HitsController < ApplicationController
  before_action :set_hit, only: [:show, :edit, :update, :destroy]

  # GET /hits
  # GET /hits.json
  def index
    @hits = Hit.all
  end

  # GET /hits/1
  # GET /hits/1.json
  def show
  end

  # GET /hits/new
  def new
    @hit = Hit.new
  end

  # GET /hits/1/edit
  def edit
  end

  # POST /hits
  # POST /hits.json
  def create
    @hit = Hit.new(hit_params)

    respond_to do |format|
      if @hit.save
        format.html { redirect_to @hit, notice: 'Hit was successfully created.' }
        format.json { render :show, status: :created, location: @hit }
      else
        format.html { render :new }
        format.json { render json: @hit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hits/1
  # PATCH/PUT /hits/1.json
  def update
    respond_to do |format|
      if @hit.update(hit_params)
        format.html { redirect_to @hit, notice: 'Hit was successfully updated.' }
        format.json { render :show, status: :ok, location: @hit }
      else
        format.html { render :edit }
        format.json { render json: @hit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hits/1
  # DELETE /hits/1.json
  def destroy
    @hit.destroy
    respond_to do |format|
      format.html { redirect_to hits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hit
      @hit = Hit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hit_params
      params.require(:hit).permit(:user_id, :ip, :request, :params, :created_at, :updated_at)
    end
end
