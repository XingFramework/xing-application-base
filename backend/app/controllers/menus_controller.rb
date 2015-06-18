class MenusController < ApplicationController
  def index
    render :json => MenuListSerializer.new(Menu.list)
  end

  # GET /admin/menus/:id
  def show
    menu = Menu.new(MenuItem.find(params[:id]))
    render :json => MenuSerializer.new(menu)
  end

  # PUT /admin/pages/:url_slug
  def update
    mapper = MenuMapper.new(json_body, params[:id])

    if mapper.save
      menu = Menu.new(MenuItem.find(params[:id]))
      render :json => MenuSerializer.new(menu)
    else
      failed_to_process(mapper.errors)
    end
  end
end
