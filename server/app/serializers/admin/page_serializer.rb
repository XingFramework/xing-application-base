class Admin::PageSerializer < PageSerializer
  attributes :published, :publish_start, :publish_end

  def links
    { :self => routes.admin_page_path(object), :public => routes.page_path(object)  }
  end
end