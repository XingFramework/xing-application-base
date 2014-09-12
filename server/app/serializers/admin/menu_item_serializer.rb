class Admin::MenuItemSerializer < BaseSerializer
  attributes :name, :path, :page_id, :parent_id

  def links
    { :self => routes.admin_menu_item_path(object)  }
  end
end