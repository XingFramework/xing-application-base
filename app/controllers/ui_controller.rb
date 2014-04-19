class UiController < ApplicationController
  def show
    render :action => params[:application]
  end
end
