class UiController < ApplicationController
  def show
    @ng_app_name = "MindSwarms.#{params[:application]}"
    render :action => params[:application]
  end
end
