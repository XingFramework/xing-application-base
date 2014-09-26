require 'spec_helper'

describe Admin::MenusController do
  let :serializer do
    double Admin::MenusSerializer
  end

  describe "GET index" do
    let :menus do
      [ double(Menu), double(Menu) ]
    end

    it "should fetch the array of menus and pass them to a serializer" do
      expect(Menu).to receive(:list).and_return(menus)
      expect(Admin::MenusSerializer).to receive(:new).and_return(serializer)
      expect(serializer).to receive(:as_json)

      get :index
    end
  end

  ########################################################################################
  #                                      PUT UPDATE
  ########################################################################################
  describe "responding to PUT update" do
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

      mock_menu_mapper.should_receive(:save).and_return(true)

      allow(mock_menu_mapper).to receive(:menu_root).and_return(mock_menu_root)
      allow(MenuItem).to receive(:find).with(menu_id.to_s).and_return(mock_menu_root)

      allow(Menu).to receive(:new).with(mock_menu_root).and_return(mock_menu)

      Admin::MenuSerializer.should_receive(:new).with(mock_menu).and_return(serializer)

      controller.should_receive(:render).with(:json => serializer).and_call_original

      put :update, json, { :id => menu_id }
    end

    it "should render status 422 if not updated" do
      allow(MenuMapper).to receive(:new).with(json, menu_id.to_s).and_return(mock_menu_mapper)

      mock_menu_mapper.should_receive(:save).and_return(false)

      allow(mock_menu_mapper).to receive(:errors).and_return(mock_errors)

      controller.should_receive(:failed_to_process).with(mock_errors).and_call_original

      put :update, json, { :id => menu_id }

      expect(response).to reject_as_unprocessable
    end
  end
end
