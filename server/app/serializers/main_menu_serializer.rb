class MainMenuSerializer < BaseSerializer

  def as_json_without_wrap
    JsonTreeLister.new(object, MainMenuNodeSerializer).render
  end

  def links
    {
      :self => routes.main_menu_path
    }
  end

end
