require 'spec_helper'

describe Admin::PagesController do

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
    #                                      GET index
    ########################################################################################
    describe "responding to GET index" do
      let :serializer do
        double(Admin::PagesSerializer)
      end

      it "should find all pages and pass them to Admin::PagesSerializer" do

        expect(Page).to receive(:all).and_return([page])
        expect(Admin::PagesSerializer).to receive(:new).with([page]).and_return(serializer)
        expect(controller).to receive(:render).
          with(:json => serializer).
          and_call_original
        get :index
      end
    end
    ########################################################################################
    #                                      GET SHOW
    ########################################################################################
    describe "responding to GET show" do

      it "should find the page and pass it to a serializer" do
        expect(Page).to receive(:find_by_url_slug).with(url_slug).and_return(page)
        expect(Admin::PageSerializer).to receive(:new).with(page).and_return(serializer)
        expect(controller).to receive(:render).
          with(:json => serializer).
          and_call_original
        get :show, :url_slug => url_slug
      end
    end

    ########################################################################################
    #                                      POST CREATE
    ########################################################################################
    describe "responding to POST create" do

      it "should create a page mapper and pass the JSON to it, then redirect to the page" do
        expect(PageMapper).to receive(:new).with(json).and_return(mock_page_mapper)
        expect(mock_page_mapper).to receive(:save).and_return(true)
        expect(mock_page_mapper).to receive(:page).and_return(mock_page)
        post :create, json

        #expect(response).to redirect_to(admin_page_path(mock_page))

        expect(response.status).to eq(201)
        expect(response.headers["Location"]).to eq(admin_page_path(mock_page))

      end

      it "should render status 422 if not saved"  do
        expect(PageMapper).to receive(:new).with(json).and_return(mock_page_mapper)
        expect(mock_page_mapper).to receive(:save).and_return(false)
        expect(mock_page_mapper).to receive(:errors).and_return(mock_errors)
        expect(controller).to receive(:failed_to_process).with(mock_errors).and_call_original

        post :create, json

        expect(response).to reject_as_unprocessable
      end

    end

    ########################################################################################
    #                                      PUT UPDATE
    ########################################################################################
    describe "responding to PUT update" do

      it "should update with page mapper and pass the JSON to it" do
        expect(PageMapper).to receive(:new).with(json, url_slug).and_return(mock_page_mapper)
        expect(mock_page_mapper).to receive(:save).and_return(true)
        expect(mock_page_mapper).to receive(:page).and_return(mock_page)
        expect(Admin::PageSerializer).to receive(:new).with(mock_page).and_return(serializer)

        expect(controller).to receive(:render).
          with(:json => serializer).
          and_call_original

        put :update, json, { :url_slug => url_slug}

      end

      it "should render status 422 if not updated" do
        expect(PageMapper).to receive(:new).with(json, url_slug).and_return(mock_page_mapper)
        expect(mock_page_mapper).to receive(:save).and_return(false)
        expect(mock_page_mapper).to receive(:errors).and_return(mock_errors)
        expect(controller).to receive(:failed_to_process).with(mock_errors).and_call_original

        post :update, json, { :url_slug => url_slug }

        expect(response).to reject_as_unprocessable
      end
    end




    ########################################################################################
    #                                      DELETE DESTROY
    ########################################################################################
    describe "DELETE destroy" do

      it "should delete the record and respond with 204" do
        expect(Page).to receive(:find_by_url_slug).with('slug').and_return(mock_page)
        expect(mock_page).to receive(:destroy)
        delete :destroy, :url_slug => 'slug'
        expect(response.status).to eql(204)
      end
    end
  end

  describe "while not logged in" do
    before(:each) do
      logout
    end

    describe "every action" do
      it "should return 401" do
        get :index
        expect(response.status).to eq(401)
        get :show, :url_slug => url_slug
        expect(response.status).to eq(401)
        put :update, :url_slug => 1
        expect(response.status).to eq(401)
        delete :destroy, :url_slug => 1
        expect(response.status).to eq(401)
        post :create
        expect(response.status).to eq(401)
      end
    end
  end
end
