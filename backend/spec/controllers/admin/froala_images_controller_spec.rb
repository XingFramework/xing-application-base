require 'spec_helper'

describe Admin::FroalaImagesController, :pending => "Needs implementation" do
  include ImageTestHelper

  ########################################################################################
  #                                      POST CREATE
  ########################################################################################
  describe "responding to POST create" do

    # it should not be blocked by before_filter
    # it should create a new image
    # it should expose the new image as @image

    it "should create a page mapper and pass the JSON to it, then redirect to the page" do
      @img = mock_proper_image(:save => true)
      Image.should_receive(:new).with(:image => 'uploaded_file').and_return(@img)
      mock_page_mapper.should_receive(:save).and_return(true)
      mock_page_mapper.should_receive(:page).and_return(mock_page)
      post :create, json

      #expect(response).to redirect_to(admin_page_path(mock_page))

      expect(response.status).to eq(201)
      expect(response.headers["Location"]).to eq(admin_page_path(mock_page))

    end

    it "should render status 422 if not saved"  do
      PageMapper.should_receive(:new).with(json).and_return(mock_page_mapper)
      mock_page_mapper.should_receive(:save).and_return(false)
      mock_page_mapper.should_receive(:errors).and_return(mock_errors)
      controller.should_receive(:failed_to_process).with(mock_errors).and_call_original

      post :create, json

      expect(response).to reject_as_unprocessable
    end

    describe "with valid params" do
      before do
        @img = mock_proper_image(:save => true)
        Image.should_receive(:new).with({'image' => 'uploaded_file'}).and_return(@img)
        post :create, :image => {:image => 'uploaded_file'}
      end

      it "should create a new image and expose it" do
        assigns(:image).should equal(@img)
      end

    end

    xdescribe "with invalid params" do
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

end
