# Serializes an array of Menu objects ... i.e. top-
# level (root) menu items
class MenuListSerializer < Xing::Serializers::Base
  def as_json_without_wrap(options={})
    object.map do |menu|
      BareMenuSerializer.new(menu).as_json
    end
  end

  def links
    { :self => routes.menus_path  }
  end

  class BareMenuSerializer < Xing::Serializers::Base
    attributes :name

    def links
      { :self => routes.menu_path(object.menu_item)  }
    end
  end
end
