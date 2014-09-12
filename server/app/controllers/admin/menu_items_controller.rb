class Admin::MenuItemsController < JsonController

  # POST /admin/menu-items
  def create
    menu_item_mapper = MenuItemMapper.new(json_body)

    # if menu_item.save
    #   redirect_to  admin_menu_item_path(menu_item_mapper.page)
    # else
    #   failed_to_process(menu_item_mapper.errors)
    # end
  end

  # PUT /admin/menu-items/:id
  def create
    menu_item_mapper = MenuItemMapper.new(json_body, params[:id])

    # if menu_item.save
    #   redirect_to  admin_menu_item_path(menu_item_mapper.page)
    # else
    #   failed_to_process(menu_item_mapper.errors)
    # end
  end

    # # DELETE /admin/pages/:url_slug
    # def destroy
    #   @admin_page = page_scope.find(params[:id])
    #   @admin_page.destroy

    #   redirect_to(:action => :index)
    # end
  end