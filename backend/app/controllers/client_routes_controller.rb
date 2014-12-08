class ClientRoutesController < ApplicationController
  def show
    @path = params[:path]
    @_escaped_fragment_ = params[:_escaped_fragment_]


    if @_escaped_fragment_
      if Rails.env.test?
        @base = "#{Rails.root}/spec/fixtures/"
      else
        @base = "#{Rails.root}/public/frontend_snapshots/"
      end
      render :file => "#{@base}#{@path}#{@_escaped_fragment_}.html"
    else
      redirect_to "/?goto=#{@path}"
    end
  end
end
