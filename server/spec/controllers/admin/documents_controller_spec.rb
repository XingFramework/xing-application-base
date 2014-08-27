require 'spec_helper'

describe Admin::DocumentsController do
  include DocumentTestHelper

  before(:each) do
    @document = FactoryGirl.create(:document)
  end

  describe "while logged in" do
    before(:each) do
      authenticate('admin')
    end
    ########################################################################################
    #                                      GET INDEX
    ########################################################################################
    describe "GET index" do
      it "should expose all admin_documents as @documents" do
        get :index
        assigns[:documents].should == [@document]
      end
    end

    ########################################################################################
    #                                      GET SHOW
    ########################################################################################
    describe "responding to GET show" do
      it "should expose the requested document as @document" do
        get :show, :id => @document.id
        assigns[:document].should == @document
      end
    end

    ########################################################################################
    #                                      GET NEW
    ########################################################################################
    describe "responding to GET new" do
      it "should expose a new document as @document" do
        get :new
        assigns[:document].should be_a(Document)
        assigns[:document].should be_new_record
      end
    end

    #######################################################################################
    #                                      POST CREATE
    ########################################################################################
    describe "responding to POST create" do

      describe "with valid params" do
        before(:each) do
          @doc = mock_document(:save => true)
          Document.should_receive(:new).with({'document' => 'uploaded_file'}).and_return(@doc)
          post :create, :document => {:document => 'uploaded_file'}
        end

        it "should create a new document and expose it" do
          assigns(:document).should equal(@doc)
        end

        it "should redirect to the created document" do
          response.should redirect_to(admin_document_url(@doc))
        end
      end

    end
    ########################################################################################
    #                                      DELETE DESTROY
    ########################################################################################
    describe "DELETE destroy" do

      it "should reduce document count by one" do
        lambda do
          delete :destroy, :id => @document.id
        end.should change(Document, :count).by(-1)
      end

      it "should make the admin_documents unfindable in the database" do
        delete :destroy, :id => @document.id
        lambda{ Document.find(@document.id)}.should raise_error(ActiveRecord::RecordNotFound)
      end

      it "should redirect to the admin_documents list" do
        delete :destroy, :id => @document.id
        response.should redirect_to(admin_documents_url)
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
        get :show, :id => 1
        response.should redirect_to(:root)
        get :new
        response.should redirect_to(:root)
        delete :destroy, :id => 1
        response.should redirect_to(:root)
        post :create
        response.should redirect_to(:root)
      end
    end
  end
end
