class MenusController < ApplicationController

  def show
    menu = Menu.new(MenuItem.find(params[:id]))
    render :json => MenuSerializer.new(menu)
  end

end
