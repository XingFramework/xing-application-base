require 'spec_helper'

describe Admin::FroalaImagesController do
  include ImageTestHelper

  describe "while logged in" do

    let :admin do FactoryGirl.create(:admin) end
    before(:each) do
      authenticate('admin')
    end

    let :img_id do
      101
    end

    let :img_url do
      "http://imageishere.com/#{img_id}/name.png"
    end

    let :valid_img do
      image = mock_proper_image(:save => true)
      allow(image).to receive_message_chain(:image, :url).and_return(img_url)
      image
    end


    ########################################################################################
    #                                      GET INDEX
    ########################################################################################
    describe "responding to GET index" do

      before(:each) do
        expect(Image).to receive(:all).and_return([valid_img])
        get :index
      end

      let :success_response do
        [valid_img.image.url].to_json
      end

      it "should expose all images as @images" do
        expect(assigns(:images)).to eq([valid_img])
      end

      it "should respond with an array of the image urls" do
        expect(response.body).to eq(success_response)
      end
    end

    ########################################################################################
    #                                      POST CREATE
    ########################################################################################
    describe "responding to POST create" do

      let :valid_params do
        { image: 'uploaded_file' }
      end

      let :success_response do
        { link: valid_img.image.url }.to_json
      end

      it "should not be rejected if request format other than json" do
        expect(Image).to receive(:new).with(:image => 'uploaded_file').and_return(valid_img)

        request.accept = 'html'
        xhr :post, :create, valid_params

        expect(response.status).not_to eq(406)
      end

      describe 'with valid params' do
        before(:each) do
          expect(Image).to receive(:new).with(:image => 'uploaded_file').and_return(valid_img)
          xhr :post, :create, valid_params
        end

        it "should create a new image and expose it" do
          expect(assigns(:image)).to equal(valid_img)
        end

        it "should create an image and pass the params to it, then redirect to the page" do
          expect(response.status).to eq(201)
          expect(response.body).to eq(success_response)
          expect(response.headers["Location"]).to eq(admin_froala_images_url(valid_img))
        end

      end

      describe 'with invalid params' do
        before(:each) do
          expect(Image).to receive(:new).with(:image => nil).and_return(invalid_img)
          xhr :post, :create, invalid_params
        end

        let :invalid_params do
          { image: nil }
        end

        let :invalid_img do
          image = mock_improper_image(:save => false )
          allow(image).to receive_message_chain(:errors, :full_messages).and_return( errors_full )
          image
        end

        let :errors_response do
          { error: errors_full }.to_json
        end

        let :errors_full do
          ["Error one", "Error 2"]
        end

        it "should create a new image and expose it" do
          expect(assigns(:image)).to equal(invalid_img)
        end

        it "should render status 422 if not saved"  do
          expect(response).to reject_as_unprocessable
        end

        it "should return relevant errors"  do
          expect(response.body).to eq(errors_response)
        end
      end
    end
    ########################################################################################
    #                                      DELETE DESTROY
    ########################################################################################
    describe "DELETE destroy" do
      it "should delete the record and respond with 204" do
        expect(Image).to receive(:find).with(img_id).and_return(valid_img)
        expect(valid_img).to receive(:destroy)
        xhr :post, :destroy, :src => valid_img.image.url
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
        xhr :post, :destroy, :src => "awesome"
        expect(response.status).to eq(401)
        post :create
        expect(response.status).to eq(401)
      end
    end
  end

end
