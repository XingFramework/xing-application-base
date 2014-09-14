
class Admin::MenuSerializer < MenuSerializer

  def links
    { :self => routes.admin_menu_path(object.menu_item)  }
  end
end
