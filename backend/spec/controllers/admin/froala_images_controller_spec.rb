require 'spec_helper'

describe Admin::FroalaImagesController do
  include ImageTestHelper

  describe "while logged in" do

    let :admin do FactoryGirl.create(:admin) end
    before(:each) do
      authenticate('admin')
    end

    let :valid_img do
      image = mock_proper_image(:save => true)
      image.stub_chain(:image, :url).and_return('http://imageishere.com')
      image
    end

    ########################################################################################
    #                                      GET index
    ########################################################################################
    describe "responding to GET index" do

      before(:each) do
        Image.should_receive(:all).and_return([valid_img])
        get :index
      end

      let :success_response do
        [valid_img.image.url].to_json
      end

      it "should expose all images as @images" do
        assigns(:images).should eq([valid_img])
      end

      it "should respond with an array of the image urls" do
        p response.body
        expect(response.body).to eq(success_response)
      end
    end

    ########################################################################################
    #                                      POST create
    ########################################################################################
    describe "responding to POST create" do

      let :valid_params do
        { image: 'uploaded_file' }
      end

      let :success_response do
        { link: 'http://imageishere.com' }.to_json
      end

      it "should not be rejected if request format other than json" do
        Image.should_receive(:new).with(:image => 'uploaded_file').and_return(valid_img)

        request.accept = 'html'
        xhr :post, :create, valid_params

        expect(response.status).not_to eq(406)
      end

      describe 'with valid params' do
        before(:each) do
          Image.should_receive(:new).with(:image => 'uploaded_file').and_return(valid_img)
          xhr :post, :create, valid_params
        end

        it "should create a new image and expose it" do
          assigns(:image).should equal(valid_img)
        end

        it "should create an image and pass the params to it, then redirect to the page" do
          expect(response.status).to eq(201)
          expect(response.body).to eq(success_response)
          expect(response.headers["Location"]).to eq(admin_froala_images_path(valid_img))
        end

      end

      describe 'with invalid params' do
        before(:each) do
          Image.should_receive(:new).with(:image => nil).and_return(invalid_img)
          xhr :post, :create, invalid_params
        end

        let :invalid_params do
          { image: nil }
        end

        let :invalid_img do
          image = mock_improper_image(:save => false )
          image.stub_chain(:errors, :full_messages) { errors_full }
          image
        end

        let :errors_response do
          { error: errors_full }.to_json
        end

        let :errors_full do
          ["Error one", "Error 2"]
        end

        it "should create a new image and expose it" do
          assigns(:image).should equal(invalid_img)
        end

        it "should render status 422 if not saved"  do
          expect(response).to reject_as_unprocessable
        end

        it "should return relevant errors"  do
          expect(response.body).to eq(errors_response)
        end
      end
    end
  end

  describe "while not logged in" do
    before(:each) do
      logout
    end

    describe "every action", :pending => "Awaiting implementation" do
      it "should redirect to root" do
        get :index
        expect(response.status).to eq(401)
        get :new
        expect(response.status).to eq(401)
        get :edit, :url_slug => 1
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
