# Serializes an array of Menu objects ... i.e. top-
# level (root) menu items
class Admin::PagesSerializer < Xing::Serializers::Base

  def as_json_without_wrap(options={})
    object.map do |menu|
      BarePageSerializer.new(menu).as_json
    end
  end
  def links
    { :self => routes.admin_pages_path  }
  end

  class BarePageSerializer < Xing::Serializers::Base
    attributes :title, :url_slug, :layout, :published, :publish_start, :publish_end

    def links
      { :self => routes.admin_page_path(object), :public => routes.page_path(object)  }
    end
  end

end
