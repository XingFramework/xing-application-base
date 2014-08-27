class Admin::ImagesController < Admin::AdminController
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
    @image = Image.new(params[:image].permit(:image))

    if @image.save
      redirect_to(admin_image_path(@image), :notice => 'Image was successfully created.')
    else
      render :action => "new"
    end
  end

  # DELETE /admin/upload/images/1
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    redirect_to(admin_images_url)
  end
end
