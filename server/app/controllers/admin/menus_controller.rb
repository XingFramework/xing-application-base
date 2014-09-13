class Admin::MenusController < JsonController


  def index
    render :json => Admin::MenusSerializer.new(Menu.list)
  end

  # GET /admin/menus/:id
  def show
    menu = Menu.new(MenuItem.find(params[:id]))
    render :json => Admin::MenuSerializer.new(menu)
  end

end
