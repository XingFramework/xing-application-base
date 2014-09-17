class Admin::PagesController < JsonController

  # GET /admin/pages
  def index
    render :json => Admin::PagesSerializer.new(Page.all)
  end

  # GET /admin/pages/:url_slug
  def show
    page = Page.find_by_url_slug(params[:url_slug])
    render :json => Admin::PageSerializer.new(page)
  end

  # POST /admin/pages
  def create
    page_mapper = PageMapper.new(json_body)

    if page_mapper.save
      #response.headers["Location"] = page_mapper.page
      #
      loc = admin_page_path(page_mapper.page)
      p loc
      #redirect_to loc
      render :status => 201, :location => loc, :json => {}

    else
      failed_to_process(page_mapper.errors)
    end
  end

  # PUT /admin/pages/:url_slug
  def update
    page_mapper = PageMapper.new(json_body, params[:url_slug])

    if page_mapper.save
      redirect_to admin_page_path(page_mapper.page)
    else
      failed_to_process(page_mapper.errors)
    end
  end

  # DELETE /admin/pages/:url_slug
  def destroy
    page = Page.find_by_url_slug(params[:url_slug])
    page.destroy

    render :status => 204, :json => {}
  end


end
