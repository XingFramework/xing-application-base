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

  describe "responding to GET index" do
    let :serializer do
      double MenuListSerializer
    end

    let :menus do
      [ double(Menu), double(Menu) ]
    end

    it "should fetch the array of menus and pass them to a serializer" do
      expect(Menu).to receive(:list).and_return(menus)
      expect(MenuListSerializer).to receive(:new).and_return(serializer)
      expect(serializer).to receive(:as_json)

      get :index
    end
  end

  ########################################################################################
  #                                      PUT UPDATE
  ########################################################################################
  describe "responding to PUT update" do
    let :serializer do
      double(MenuSerializer)
    end

    let :menu_id do
      1
    end

    let :json do
      { doesnt: "really", matter: "what's", in: "here" }.to_json
    end

    let :mock_errors do
      { data: "Errors are stupid, and they look funny." }
    end

    let :mock_menu_mapper do
      double(MenuMapper)
    end

    let :mock_menu_root do
      double(MenuItem)
    end

    let :mock_menu do
      double(Menu)
    end

    it "should update with page mapper and pass the JSON to it" do
      allow(MenuMapper).to receive(:new).with(json, menu_id.to_s).and_return(mock_menu_mapper)

      expect(mock_menu_mapper).to receive(:save).and_return(true)

      allow(mock_menu_mapper).to receive(:menu_root).and_return(mock_menu_root)
      allow(MenuItem).to receive(:find).with(menu_id.to_s).and_return(mock_menu_root)

      allow(Menu).to receive(:new).with(mock_menu_root).and_return(mock_menu)

      expect(MenuSerializer).to receive(:new).with(mock_menu).and_return(serializer)

      expect(controller).to receive(:render).with(:json => serializer).and_call_original

      put :update, json, { :id => menu_id }
    end

    it "should render status 422 if not updated" do
      allow(MenuMapper).to receive(:new).with(json, menu_id.to_s).and_return(mock_menu_mapper)

      expect(mock_menu_mapper).to receive(:save).and_return(false)

      allow(mock_menu_mapper).to receive(:errors).and_return(mock_errors)

      expect(controller).to receive(:failed_to_process).with(mock_errors).and_call_original

      put :update, json, { :id => menu_id }

      expect(response).to reject_as_unprocessable
    end
  end
end
