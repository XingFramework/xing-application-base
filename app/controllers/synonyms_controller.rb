class SynonymsController < ApplicationController
  before_action :set_synonym, only: [:show, :edit, :update, :destroy]

  # GET /synonyms
  # GET /synonyms.json
  def index
    @synonyms = Synonym.all
  end

  # GET /synonyms/1
  # GET /synonyms/1.json
  def show
  end

  # GET /synonyms/new
  def new
    @synonym = Synonym.new
  end

  # GET /synonyms/1/edit
  def edit
  end

  # POST /synonyms
  # POST /synonyms.json
  def create
    @synonym = Synonym.new(synonym_params)

    respond_to do |format|
      if @synonym.save
        format.html { redirect_to @synonym, notice: 'Synonym was successfully created.' }
        format.json { render :show, status: :created, location: @synonym }
      else
        format.html { render :new }
        format.json { render json: @synonym.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /synonyms/1
  # PATCH/PUT /synonyms/1.json
  def update
    respond_to do |format|
      if @synonym.update(synonym_params)
        format.html { redirect_to @synonym, notice: 'Synonym was successfully updated.' }
        format.json { render :show, status: :ok, location: @synonym }
      else
        format.html { render :edit }
        format.json { render json: @synonym.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /synonyms/1
  # DELETE /synonyms/1.json
  def destroy
    @synonym.destroy
    respond_to do |format|
      format.html { redirect_to synonyms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_synonym
      @synonym = Synonym.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def synonym_params
      params.require(:synonym).permit(:name, :tag_id, :created_at, :updated_at)
    end
end
