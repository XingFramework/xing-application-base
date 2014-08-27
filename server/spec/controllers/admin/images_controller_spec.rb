require 'spec_helper'

describe Admin::ImagesController do
  include ImageTestHelper

  before(:each) do
    @image = FactoryGirl.create(:image)
  end

  describe "while logged in" do
    before(:each) do
      authenticate('admin')
    end
    ########################################################################################
    #                                      GET INDEX
    ########################################################################################
    describe "GET index" do
      it "should expose all admin_images as @images" do
        get :index
        assigns[:images].should == [@image]
      end
    end

    ########################################################################################
    #                                      GET SHOW
    ########################################################################################
    describe "responding to GET show" do
      it "should expose the requested image as @image" do
        get :show, :id => @image.id
        assigns[:image].should == @image
      end
    end

    ########################################################################################
    #                                      GET NEW
    ########################################################################################
    describe "responding to GET new" do
      it "should expose a new image as @image" do
        get :new
        assigns[:image].should be_a(Image)
        assigns[:image].should be_new_record
      end
    end

    ########################################################################################
    #                                      POST CREATE
    ########################################################################################
    describe "responding to POST create" do

      describe "with valid params" do
        before do
          @img = mock_proper_image(:save => true)
          Image.should_receive(:new).with({'image' => 'uploaded_file'}).and_return(@img)
          post :create, :image => {:image => 'uploaded_file'}
        end

        it "should create a new image and expose it" do
          assigns(:image).should equal(@img)
        end

        it "should redirect to the created image" do
          response.should redirect_to(admin_image_url(@img))
        end
      end

      describe "with invalid params" do
        before do
          lambda do
            @img = mock_improper_image(:save => false)
            Image.should_receive(:new).with({'image' => 'uploaded_file'}).and_return(@img)
            post :create, :image => {:image => 'uploaded_file'}
          end.should_not change(Image, :count)
        end

        it "should expose a newly created image as @image" do
          assigns(:image).should equal(@img)
        end


        it "should re-render the 'new' template" do
          response.should render_template('new')
        end
      end
    end

    ########################################################################################
    #                                      DELETE DESTROY
    ########################################################################################
    describe "DELETE destroy" do

      it "should reduce image count by one" do
        lambda do
          delete :destroy, :id => @image.id
        end.should change(Image, :count).by(-1)
      end

      it "should make the admin_images unfindable in the database" do
        delete :destroy, :id => @image.id
        lambda{ Image.find(@image.id)}.should raise_error(ActiveRecord::RecordNotFound)
      end

      it "should redirect to the admin_images list" do
        delete :destroy, :id => @image.id
        response.should redirect_to(admin_images_url)
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
