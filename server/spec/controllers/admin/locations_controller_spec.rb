require 'spec_helper'

describe Admin::LocationsController do

  describe "logged in as admin" do
    before(:each) do
      @location = FactoryGirl.create(:location, :parent => Location.root)
      authenticate('admin')
    end

    ########################################################################################
    #                                      GET INDEX
    ########################################################################################
    describe "GET index" do
      it "should expose all locations as @locations" do
        get :index
        assigns[:locations].should include @location
      end
    end

    ########################################################################################
    #                                      GET NEW
    ########################################################################################
    describe "responding to GET new" do
      it "should expose a new location as @location" do
        get :new
        assigns[:location].should be_a(Location)
        assigns[:location].should be_new_record
      end
    end

    ########################################################################################
    #                                      GET EDIT
    ########################################################################################
    describe "responding to GET edit" do
      it "should expose the requested location as @location" do
        get :edit, :id => @location.id
        assigns[:location].should == @location
      end
    end

    ########################################################################################
    #                                      POST CREATE
    ########################################################################################
    describe "responding to POST create" do

      describe "with valid params" do
        before do
          @valid_create_params = {
            :name => "Location One",
            :path => 'location/1'
          }
        end

        it "should create a new location in the database" do
          lambda do
            post :create, :location => @valid_create_params
          end.should change(Location, :count).by(1)
        end

        it "should expose a saved location as @location" do
          post :create, :location => @valid_create_params
          assigns[:location].should be_a(Location)
        end

        it "should save the newly created location as @location" do
          post :create, :location => @valid_create_params
          assigns[:location].should_not be_new_record
        end

        it "should redirect to the created location" do
          post :create, :location => @valid_create_params
          new_location = assigns[:location]
          response.should redirect_to(admin_locations_url)
        end
      end

      describe "with invalid params" do
        before do
          @invalid_create_params = {
            :name => nil,
            :path => 'location/1'
          }
        end

        it "should not create a new location in the database" do
          lambda do
            post :create, :location => @invalid_create_params
          end.should_not change(Location, :count)
        end

        it "should expose a newly created location as @location" do
          post :create, :location => @invalid_create_params
          assigns(:location).should be_a(Location)
        end

        it "should expose an unsaved location as @location" do
          post :create, :location => @invalid_create_params
          assigns(:location).should be_new_record
        end

        it "should re-render the 'new' template" do
          post :create, :location => @invalid_create_params
          response.should render_template('new')
        end
      end
    end

    ########################################################################################
    #                                      PUT UPDATE
    ########################################################################################
    describe "responding to PUT update" do

      describe "when moving a location" do
        before do
          @parent = FactoryGirl.create(:location)
          @l1 = FactoryGirl.create(:location, :name => "Location 1")
          @l2 = FactoryGirl.create(:location, :name => "Location 2")
          @l3 = FactoryGirl.create(:location, :name => "Location 3")
          @l1.move_to_child_of(@parent)
          @l2.move_to_child_of(@parent)
          @l3.move_to_child_of(@parent)
        end

        it "should start out configured correctly" do
          @l1.left_sibling.should be_nil
          @l1.right_sibling.should == @l2
          @l2.right_sibling.should == @l3
          @l3.right_sibling.should be_nil
        end

        it "should move second location to the beginning of the list" do
          put :update, :id => @l2, :location => {:move_to => @l1.id}
          @l2.reload
          @l2.left_sibling.should be_nil
          @l2.right_sibling.should == @l1
        end

        it "should move first location to the end of the list" do
          put :update, :id => @l1, :location => {:move_to => "last"}
          @l2.reload.left_sibling.should be_nil
          @l3.reload.right_sibling.should == @l1
        end
      end

      describe "with valid params" do
        before do
          @valid_update_params = {
            :name => 'location 1',
            :path => 'location/1',
            # Testing for empty move_to important for Rails 3 which
            # includes parameters
            :move_to => ''
          }
        end

        it "should update the requested location in the database" do
          lambda do
            put :update, :id => @location.id, :location => @valid_update_params
          end.should change{ @location.reload.attributes }
        end

        it "should expose the requested location as @location" do
          put :update, :id => @location.id, :location => @valid_update_params
          assigns(:location).should == @location
        end

        it "should redirect to the location" do
          put :update, :id => @location.id, :location => @valid_update_params
          response.should redirect_to(admin_locations_url)
        end
      end

      describe "with invalid params" do
        before do
          @invalid_update_params = {
            :name => nil,
            :path => 'fine'
          }
        end

        it "should not change the location in the database" do
          lambda do
            put :update, :id => @location.id, :location => @invalid_update_params
          end.should_not change{ @location.reload }
        end

        it "should expose the location as @location" do
          put :update, :id => @location.id, :location => @invalid_update_params
          assigns(:location).should == @location
        end

        it "should re-render the 'edit' template" do
          put :update, :id => @location.id, :location => @invalid_update_params
          response.should render_template('edit')
        end
      end
    end


    ########################################################################################
    #                                      DELETE DESTROY
    ########################################################################################
    describe "DELETE destroy" do

      it "should reduce location count by one" do
        lambda do
          delete :destroy, :id => @location.id
        end.should change(Location, :count).by(-1)
      end

      it "should make the locations unfindable in the database" do
        delete :destroy, :id => @location.id
        lambda{ Location.find(@location.id)}.should raise_error(ActiveRecord::RecordNotFound)
      end

      it "should redirect to the locations list" do
        delete :destroy, :id => @location.id
        response.should redirect_to(admin_locations_url)
      end
    end
  end

end
