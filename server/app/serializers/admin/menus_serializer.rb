# Serializes an array of Menu objects ... i.e. top-
# level (root) menu items
class Admin::MenusSerializer < BaseSerializer

  def as_json_without_wrap(options={})
    object.map do |menu|
      Admin::BareMenuSerializer.new(menu).as_json
    end
  end
  def links
    { :self => routes.admin_menus_path  }
  end
end