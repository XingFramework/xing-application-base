class Admin::FroalaImagesController < Admin::AdminController
  skip_before_filter :check_format, only: :create

  # POST /admin/upload/images
  def create
    @image = Image.new(:image => params['image'])

    if @image.save
      response = { link: @image.image.url }
      render :status => 201, :json => response, :location => admin_froala_images_path(@image)
    else
      response = { error: "Didn't upload!" } # display better errors
      render :status => 422, :json => response
    end
  end

end
