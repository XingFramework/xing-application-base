class Admin::FroalaImagesController < Admin::AdminController
  skip_before_filter :check_format, only: [:index, :create, :destroy]
  skip_before_filter :reject_if_not_logged_in

  # GET /admin/froala_images/
  def index
    @images = Image.all
    response = @images.map{|img| img.image.url }

    render :json => response, :root => false
  end

  # POST /admin/froala_images/delete
  def destroy
    image_id = params[:src].split('/')[-2].to_i
    image = Image.find(image_id)
    image.destroy

    render :status => 204, :json => {}
  end

  # POST /admin/froala_images/
  def create
    @image = Image.new(:image => params['image'])

    if @image.save
      response = { link: @image.image.url }
      render :status => 201, :json => response, :location => admin_froala_images_path(@image)
    else
      response = { error: @image.errors.full_messages }
      render :status => 422, :json => response
    end
  end

end
