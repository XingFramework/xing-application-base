class Admin::ImagesController < Admin::AdminController
  skip_before_filter :check_format, only: :create
  # GET /admin/upload/images
  def index
    @images = Image.all
  end

  # GET /admin/upload/images/1
  def show
    @image = Image.find(params[:id])
  end

  # GET /admin/upload/images/new
  def new
    @image = Image.new
  end

  # POST /admin/upload/images
  def create
    @image = Image.new(:image => params['image'])

    if @image.save
      response = { link: @image.image.url }
      render :status => 201, :json => response, :location => admin_images_path(@image)
    else
      response = { error: "Didn't upload!" }
      render :status => 422, :json => response
    end
  end

  # DELETE /admin/upload/images/1
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    redirect_to(admin_images_url)
  end
end
