class MainMenuController < ApplicationController
  respond_to :json

  def show
    main_menu_root = MenuItem.roots.where(:name => "Main Menu").first
    @main_menu = Menu.new(main_menu_root)
    render :json => MainMenuSerializer.new(@main_menu)
  end

end