class Admin::MenusController < JsonController


  def index
    render :json => Admin::MenusSerializer.new(Menu.list)
  end

  # GET /admin/menus/:id
  def show
    @menu_item = MenuItem.find(params[:id])
    render :json => Admin::MenuItemSerializer.new(@menu_item)
  end

end
