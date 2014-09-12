class Admin::MenuItemsController < JsonController

  # GET /admin/menu_items/:id
  def show
    @menu_item = MenuItem.find(params[:id])
    render :json => Admin::MenuItemSerializer.new(@menu_item)
  end

  # POST /admin/menu-items
  def create
    menu_item_mapper = MenuItemMapper.new(json_body)

    if menu_item_mapper.save
      redirect_to  admin_menu_item_path(menu_item_mapper.menu_item)
    else
      failed_to_process(menu_item_mapper.errors)
    end
  end

  # PUT /admin/menu-items/:id
  def update
    menu_item_mapper = MenuItemMapper.new(json_body, params[:id])

    if menu_item_mapper.save
      redirect_to  admin_menu_item_path(menu_item_mapper.menu_item)
    else
      failed_to_process(menu_item_mapper.errors)
    end
  end

    # DELETE /admin/menu_items/:id
    def destroy
      menu_item = MenuItem.find(params[:id])
      menu_item.destroy

      redirect_to admin_menus_path
    end
  end