class MenuSerializer < BaseSerializer

  def as_json_without_wrap
    JsonTreeLister.new(object.tree, MenuNodeSerializer).render
  end

  def links
    {
      :self => routes.menu_path(object)
    }
  end

end
