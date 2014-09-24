require 'spec_helper'

describe MenusController do

  ########################################################################################
  #                                      GET SHOW
  ########################################################################################
  describe "responding to GET show" do
    let :menu do
      double(Menu)
    end

    let :main_menu_root do
      double(MenuItem)
    end

    let :serializer do
      double(MenuSerializer)
    end

    it "should expose the requested published page as @page" do
      expect(MenuItem).to receive(:find).with("1").and_return(main_menu_root)
      expect(Menu).to     receive(:new).with(main_menu_root).and_return(menu)
      expect(MenuSerializer).to receive(:new).with(menu).and_return(serializer)
      get :show, :id => 1
    end
  end
end
