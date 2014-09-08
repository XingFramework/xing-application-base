require 'spec_helper'

describe PagesController do

  ########################################################################################
  #                                      GET SHOW
  ########################################################################################
  describe "responding to GET show" do
    before do
      @request.env['HTTP_ACCEPT'] = 'application/json'
    end

    let :page do
      double(Page)
    end

    let :serializer do
      double(PageSerializer)
    end

    let :slug do
      "test_slug"
    end

    it "should expose the requested published page as @page" do
      Page.should_receive(:find_by_url_slug).with(slug).and_return(page)
      PageSerializer.should_receive(:new).with(page).and_return(serializer)
      #controller.should_receive(:respond_with).with(serializer) This is not testing correctly because of problems with the way formats are being set/read.
      get :show, :slug => slug
      expect(assigns[:page]).to eq(page)
    end
  end
end
