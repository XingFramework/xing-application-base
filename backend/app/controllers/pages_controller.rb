class PagesController < ApplicationController
  respond_to :json

  def show
    path = params[:url_slug]
    @page = Page.find_by_url_slug(path)
    render :json => PageSerializer.new(@page)
  end
end