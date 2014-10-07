require 'spec_helper'

describe Admin::FroalaDocumentsController do
  include DocumentTestHelper

  before(:each) do
    @document = FactoryGirl.create(:document)
  end

  describe "while logged in" do
    let :admin do FactoryGirl.create(:admin) end
    before(:each) do
      authenticate('admin')
    end

    let :doc_id do
      101
    end

    let :doc_url do
      "http://doc.com/#{doc_id}/name.pdf"
    end

    let :valid_doc do
      document = mock_document(:save => true)
      document.stub_chain(:data, :url).and_return(doc_url)
      document
    end

    ########################################################################################
    #                                      POST CREATE
    ########################################################################################
    describe "responding to POST create" do

      let :valid_params do
        { document: 'uploaded_file' }
      end

      let :success_response do
        { link: valid_doc.data.url }.to_json
      end

      it "should not be rejected if request format other than json" do
        Document.should_receive(:new).with(:data => 'uploaded_file').and_return(valid_doc)

        request.accept = 'html'
        xhr :post, :create, valid_params

        expect(response.status).not_to eq(406)
      end

      describe 'with valid params' do
        before(:each) do
          Document.should_receive(:new).with(:data => 'uploaded_file').and_return(valid_doc)
          xhr :post, :create, valid_params
        end

        it "should create a new document and expose it" do
          assigns(:document).should equal(valid_doc)
        end

        it "should create an document and pass the params to it, then redirect to the page" do
          expect(response.status).to eq(201)
          expect(response.body).to eq(success_response)
          expect(response.headers["Location"]).to eq(admin_froala_documents_path(valid_doc))
        end

      end

      describe 'with invalid params' do
        before(:each) do
          Document.should_receive(:new).with(:data => nil).and_return(invalid_doc)
          xhr :post, :create, invalid_params
        end

        let :invalid_params do
          { document: nil }
        end

        let :invalid_doc do
          document = mock_document(:save => false )
          document.stub_chain(:errors, :full_messages) { errors_full }
          document
        end

        let :errors_response do
          { error: errors_full }.to_json
        end

        let :errors_full do
          ["Error one", "Error 2"]
        end

        it "should create a new document and expose it" do
          assigns(:document).should equal(invalid_doc)
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
        post :create
        response.should redirect_to(:root)
      end
    end
  end
end
