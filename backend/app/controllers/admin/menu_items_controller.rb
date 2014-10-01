class Admin::MenuItemsController < JsonController

  # GET /admin/menu_items/:id
  def show
    @menu_item = MenuItem.find(params[:id])
    render :json => Admin::MenuItemSerializer.new(@menu_item)
  end

  # POST /admin/menu-items
  def create
    mapper = MenuItemMapper.new(json_body)

    if mapper.save
      successful_create(admin_menu_item_path(mapper.menu_item))
    else
      failed_to_process(mapper.errors)
    end
  end

  # PUT /admin/menu-items/:id
  def update
    mapper = MenuItemMapper.new(json_body, params[:id])

    if mapper.save
      render :json => Admin::MenuItemSerializer.new(mapper.menu_item)
    else
      failed_to_process(mapper.errors)
    end
  end

  # DELETE /admin/menu_items/:id
  def destroy
    menu_item = MenuItem.find(params[:id])
    menu_item.destroy

    redirect_to menus_path
  end
end
