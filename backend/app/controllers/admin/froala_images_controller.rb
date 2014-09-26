class Admin::FroalaImagesController < Admin::AdminController
  skip_before_filter :check_format, only: :create

  # GET /admin/froala-images/index

  # POST /admin/froala-images/delete => :destroy

  # POST /admin/upload/images
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
