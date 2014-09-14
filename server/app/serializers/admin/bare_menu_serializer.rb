
class Admin::BareMenuSerializer < BaseSerializer
  attributes :name

  def links
    { :self => routes.admin_menu_path(object.menu_item)  }
  end
end
