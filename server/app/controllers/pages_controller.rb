class PagesController < ApplicationController
  # GET /*permalink
  def show
    path = params[:permalink]
    @page = Page.find_by_permalink(path)

    if !@page.nil? && (admin? || @page.published?)
      if !@page.published?
        flash.now[:notice] = "This page is not currently viewable by the public."
      end

      @title = @page.title
      if @page.layout.nil?
        render
      else
        render :layout => @page.layout
      end
    else
      @page = nil
      Rails.logger.info{"Returning 404 for #{path}"}
      render "public/404", :format => [:html],  :status => 404
    end
  end
end
