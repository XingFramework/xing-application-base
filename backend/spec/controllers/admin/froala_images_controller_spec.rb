require 'spec_helper'

describe Admin::FroalaImagesController do
  include ImageTestHelper

  ########################################################################################
  #                                      POST CREATE
  ########################################################################################
  describe "responding to POST create" do

    # it should expose the new image as @image
    let :valid_params do
      { image: 'uploaded_file' }
    end

    let :invalid_params do
      { image: nil }
    end

    let :valid_img do
      image = mock_proper_image(:save => true )
      image.stub_chain(:image, :url).and_return('http://imageishere.com')
      image
    end

    let :invalid_img do
      mock_improper_image(:save => false)
    end

    let :expected_response do
      { link: 'http://imageishere.com' }.to_json
    end

    it "should not be rejected if request format other than json" do
      Image.should_receive(:new).with(:image => 'uploaded_file').and_return(valid_img)

      request.accept = 'html'
      post :create, valid_params

      expect(response.status).not_to eq(406)
    end

    it "should create an image and pass the params to it, then redirect to the page" do
      Image.should_receive(:new).with(:image => 'uploaded_file').and_return(valid_img)
      post :create, valid_params

      expect(response.status).to eq(201)
      expect(response.body).to eq(expected_response)
      expect(response.headers["Location"]).to eq(admin_froala_images_path(valid_img))

    end

    it "should render status 422 if not saved"  do
      Image.should_receive(:new).with(:image => nil).and_return(invalid_img)

      post :create, invalid_params

      expect(response).to reject_as_unprocessable
    end

    # describe "with valid params" do
    #   before do
    #     @img = mock_proper_image(:save => true)
    #     Image.should_receive(:new).with({'image' => 'uploaded_file'}).and_return(@img)
    #     post :create, :image => {:image => 'uploaded_file'}
    #   end

    #   it "should create a new image and expose it" do
    #     assigns(:image).should equal(@img)
    #   end

    # end

    # describe "with invalid params" do
    #   before do
    #     lambda do
    #       @img = mock_improper_image(:save => false)
    #       Image.should_receive(:new).with({'image' => 'uploaded_file'}).and_return(@img)
    #       post :create, :image => {:image => 'uploaded_file'}
    #     end.should_not change(Image, :count)
    #   end

    #   it "should expose a newly created image as @image" do
    #     assigns(:image).should equal(@img)
    #   end


    #   it "should re-render the 'new' template" do
    #     response.should render_template('new')
    #   end
    # end
  end

end
