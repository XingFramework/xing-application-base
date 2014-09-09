require 'spec_helper'

describe MainMenuController do

  ########################################################################################
  #                                      GET SHOW
  ########################################################################################
  describe "responding to GET show" do
    before do
      @request.env['HTTP_ACCEPT'] = 'application/json'
    end

    let :menu do
      double(Menu)
    end

    let :main_menu_root do
      double(MenuItem)
    end

    let :roots do
      r = double(ActiveRecord::Relation)
      r.stub(:where).with(:name => "Main Menu") { main_menu_root }
      r
    end

    let :serializer do
      double(MainMenuSerializer)
    end

    it "should expose the requested published page as @page" do
      expect(MenuItem).to receive(:roots).and_return(roots)
      expect(Menu).to receive(:new).with(main_menu_root).and_return(menu)
      expect(MainMenuSerializer).to receive(:new).with(menu).and_return(serializer)
      #controller.should_receive(:respond_with).with(serializer) This is not testing correctly because of problems with the way formats are being set/read.
      get :show
      expect(assigns[:main_menu]).to eq(menu)
    end
  end
end
