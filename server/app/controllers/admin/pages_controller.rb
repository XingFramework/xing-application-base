class Admin::PagesController < JsonController

  # GET /admin/pages
  def index
    @pages = page_scope
    @human_plural_name
  end

  # GET /admin/pages/:url_slug
  def show
    path = params[:url_slug]
    @page = Page.find_by_url_slug(path)
    render :json => Admin::PageSerializer.new(@page)
  end

  # POST /admin/pages
  def create
    page_mapper = PageMapper.new(json_body)

    if page_mapper.save
      redirect_to  admin_page_path(page_mapper.page)
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
    @admin_page = page_scope.find(params[:id])
    @admin_page.destroy

    redirect_to(:action => :index)
  end

  # def page_path(page)
  #   "/#{page.permalink}"
  # end
  #
  private

  def human_name
    "Page"
  end

  def human_plural_name
    "Pages"
  end

  def location_handling
  end

  def page_layout
    nil
  end

  def page_scope
    Page.brochure
  end

  def page_params
    @page_params ||= params.required(:page).tap do |page_params|

    if page_params.delete(:published)
      page_params[:published_start] = Time.at(0)
    else
      page_params[:published_end] = Time.at(0)
    end

      page_params[:layout] = page_layout
    end
  end

  def page_attrs
    page_params.permit(:title, :permalink, :content, :edited_at, :description,
                      :headline, :keywords, :publish_start, :publish_end, :layout, :css)
  end
end
