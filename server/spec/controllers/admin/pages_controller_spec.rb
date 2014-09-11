require 'spec_helper'

describe Admin::PagesController do
  include UrlHelper

  let :page do
    double(Page)
  end

  let :serializer do
    double(Admin::PageSerializer)
  end

  let :url_slug do
    "test_slug"
  end

  let :json do
    { stuff: "like this", more: "like that", layout: "one_column" }.to_json
  end

  let :mock_page_mapper do
    double PageMapper
  end
  let :mock_page do
    double Page, :url_slug => url_slug
  end
  let :mock_errors do
    { data: { some_field: "Is required" }}
  end

  describe "while logged in" do
    let :admin do FactoryGirl.create(:admin) end
    before(:each) do
      authenticate('admin')
    end

    ########################################################################################
    #                                      GET SHOW
    ########################################################################################
    describe "responding to GET show" do

      it "should expose the requested published page as @page" do
        Page.should_receive(:find_by_url_slug).with(url_slug).and_return(page)
        Admin::PageSerializer.should_receive(:new).with(page).and_return(serializer)
        controller.should_receive(:render).
          with(:json => serializer).
          and_call_original
        get :show, :url_slug => url_slug
        expect(assigns[:page]).to eq(page)
      end
    end

    ########################################################################################
    #                                      POST CREATE
    ########################################################################################
    describe "responding to POST create" do

      it "should create a page mapper and pass the JSON to it, then redirect to the page" do
        PageMapper.should_receive(:new).with(json).and_return(mock_page_mapper)
        mock_page_mapper.should_receive(:save).and_return(true)
        mock_page_mapper.should_receive(:page).and_return(mock_page)
        post :create, json

        expect(response).to redirect_to(admin_page_path(mock_page))
      end

      it "should render status 422 if not saved", :pending => "solution to render problem"  do
        PageMapper.should_receive(:new).with(json).and_return(mock_page_mapper)
        mock_page_mapper.should_receive(:save).and_return(false)
        mock_page_mapper.should_receive(:errors).and_return(mock_errors)
        controller.should_receive(:render).with(:status => 422, :json => mock_errors).and_call_original

        post :create, json

        expect(response.status).to eq(422)
      end

    end

    ########################################################################################
    #                                      PUT UPDATE
    ########################################################################################
    describe "responding to PUT update" do

      it "should update with page mapper and pass the JSON to it" do
        PageMapper.should_receive(:new).with(json, url_slug).and_return(mock_page_mapper)
        mock_page_mapper.should_receive(:save).and_return(true)
        mock_page_mapper.should_receive(:page).and_return(mock_page)
        put :update, json, { :url_slug => url_slug}

        expect(response).to redirect_to(admin_page_path(mock_page))
      end

      it "should render status 422 if not updated" do
        PageMapper.should_receive(:new).with(json, url_slug).and_return(mock_page_mapper)
        mock_page_mapper.should_receive(:save).and_return(false)
        mock_page_mapper.should_receive(:errors).and_return(mock_errors)
        controller.should_receive(:render).with(:status => 422, :json => mock_errors).and_call_original

        post :update, json, { :url_slug => url_slug }

        expect(response.status).to eq(422)
      end
    end
  end



  describe "pending", :pending => "Awaiting implementation in CMS2" do
    describe "while logged in" do
      let :admin do FactoryGirl.create(:admin) end
      before(:each) do
        authenticate('admin')
      end

      ########################################################################################
      #                                      GET INDEX
      ########################################################################################
      describe "GET index" do
        it "should expose all pages as @pages" do
          get :index
          assigns[:pages].should == Page.brochure
          assigns[:pages].should include(page)
          assigns[:pages].should_not include(blog_post)
        end
      end


      ########################################################################################
      #                                      DELETE DESTROY
      ########################################################################################
      describe "DELETE destroy" do

        it "should reduce page count by one" do
          lambda do
            delete :destroy, :id => page.id
          end.should change(Page, :count).by(-1)
        end

        it "should make the admin_pages unfindable in the database" do
          delete :destroy, :id => page.id
          lambda{ Page.find(page.id) }.should raise_error(ActiveRecord::RecordNotFound)
        end

        it "should redirect to the admin_pages list" do
          delete :destroy, :id => page.id
          response.should redirect_to(admin_pages_url)
        end
      end
    end

    describe "while not logged in" do
      before(:each) do
        logout
      end

      describe "every action" do
        it "should redirect to root" do
          get :index
          response.should redirect_to(:root)
          get :new
          response.should redirect_to(:root)
          get :edit, :id => 1
          response.should redirect_to(:root)
          put :update, :id => 1
          response.should redirect_to(:root)
          delete :destroy, :id => 1
          response.should redirect_to(:root)
          post :create
          response.should redirect_to(:root)
        end
      end
    end
  end
end
