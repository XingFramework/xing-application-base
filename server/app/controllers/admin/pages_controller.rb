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
    mapper = PageMapper.new(json_body)

    if mapper.save
      successful_create(admin_page_path(mapper.page))
    else
      failed_to_process(mapper.errors)
    end
  end

  # PUT /admin/pages/:url_slug
  def update
    mapper = PageMapper.new(json_body, params[:url_slug])

    if mapper.save
      render :json => Admin::PageSerializer.new(mapper.page)
    else
      failed_to_process(mapper.errors)
    end
  end

  # DELETE /admin/pages/:url_slug
  def destroy
    page = Page.find_by_url_slug(params[:url_slug])
    page.destroy

    render :status => 204, :json => {}
  end


end
