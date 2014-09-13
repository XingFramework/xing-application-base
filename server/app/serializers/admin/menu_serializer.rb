
# Serializes an array of Menu objects ... i.e. top-
# level (root) menu items
class Admin::MenuSerializer < BaseSerializer
  attributes :name

  def links
    { :self => routes.admin_menu_path(object.menu_item)  }
  end
end
