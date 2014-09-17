require 'spec_helper'

describe Admin::MenuItemsController do
 before do
    @request.env['HTTP_ACCEPT'] = 'application/json'
  end

  let :menu_item do
    double(MenuItem)
  end

  let :serializer do
    double(Admin::MenuItemSerializer)
  end

  let :id do
    "12"
  end

  let :json do
    { stuff: "like this", more: "like that"}.to_json
  end

  let :mock_menu_item_mapper do
    double(MenuItemMapper)
  end

  let :mock_menu_item do
    double(MenuItem, :id => id)
  end

  let :mock_errors do
    { data: { some_field: "Is required" }}
  end

  # TODO add this back when we have authentication
  # let :admin do FactoryGirl.create(:admin) end
  # before(:each) do
  #   authenticate('admin')
  # end


  ########################################################################################
  #                                      GET SHOW
  ########################################################################################
  describe "responding to GET show" do

    it "should expose the requested published menu_item as @menu_item" do
      MenuItem.should_receive(:find).with(id).and_return(menu_item)
      Admin::MenuItemSerializer.should_receive(:new).with(menu_item).and_return(serializer)
      controller.should_receive(:render).
        with(:json => serializer).
        and_call_original
      get :show, :id => id
      expect(assigns[:menu_item]).to eq(menu_item)
    end
  end

  ########################################################################################
  #                                      POST CREATE
  ########################################################################################
  describe "responding to POST create" do
    it "creates a new menu item mapper and pass the JSON to it, then redirect to " do
      MenuItemMapper.should_receive(:new).with(json).and_return(mock_menu_item_mapper)
      mock_menu_item_mapper.should_receive(:save).and_return(true)
      mock_menu_item_mapper.should_receive(:menu_item).and_return(mock_menu_item)
      post :create, json

      expect(response.status).to eq(201)
      expect(response.headers["Location"]).to eq(admin_menu_item_path(mock_menu_item))
    end
  end

  it "should render status 422 if not saved"  do
    MenuItemMapper.should_receive(:new).with(json).and_return(mock_menu_item_mapper)
    mock_menu_item_mapper.should_receive(:save).and_return(false)
    mock_menu_item_mapper.should_receive(:errors).and_return(mock_errors)
    controller.should_receive(:failed_to_process).with(mock_errors).and_call_original

    post :create, json

    expect(response).to reject_as_unprocessable
  end

  ########################################################################################
  #                                      PUT UPDATE
  ########################################################################################
  describe "responding to PUT update" do

    it "should update with menu item mapper and pass the JSON to it" do
      MenuItemMapper.should_receive(:new).with(json, id).and_return(mock_menu_item_mapper)
      mock_menu_item_mapper.should_receive(:save).and_return(true)
      mock_menu_item_mapper.should_receive(:menu_item).and_return(mock_menu_item)
      Admin::MenuItemSerializer.should_receive(:new).with(mock_menu_item).and_return(serializer)

      controller.should_receive(:render).
        with(:json => serializer).
        and_call_original

      put :update, json, { :id => id}
    end

    it "should render status 422 if not updated" do
      MenuItemMapper.should_receive(:new).with(json, id).and_return(mock_menu_item_mapper)
      mock_menu_item_mapper.should_receive(:save).and_return(false)
      mock_menu_item_mapper.should_receive(:errors).and_return(mock_errors)
      controller.should_receive(:failed_to_process).with(mock_errors).and_call_original

      post :update, json, { :id => id }

      expect(response).to reject_as_unprocessable
    end
  end

  ########################################################################################
  #                                      DELETE DESTROY
  ########################################################################################
  describe "DELETE destroy" do

    it "should find menu item and destroy" do
      MenuItem.should_receive(:find).with(id).and_return(menu_item)
      menu_item.should_receive(:destroy).and_return(:true)
      delete :destroy, :id => id

      expect(response).to redirect_to(admin_menus_path)
    end
  end
end
