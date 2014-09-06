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
      #controller.should_receive(:respond_with).with(serializer)
      get :show, :slug => slug
      expect(assigns[:page]).to eq(page)
    end

    # describe "for a non-existent page" do
    #   it "should return status 404" do
    #     get :show, :prefix => 'test', :permalink => "how_do_we_know_that_we_truly_exist"
    #     response.status.should == 404
    #   end
    # end

    # describe "for an unpublished page" do
    #   let! :page do
    #     FactoryGirl.create(:page, :publish_end => Time.now - 1.day)
    #   end

    #   before(:each) do
    #     get :show,
    #         :permalink => page.permalink
    #   end
    #   it "should not expose the page as @page" do
    #     assigns[:page].should == nil
    #   end
    #   it "should return status 404" do
    #     response.status.should == 404
    #   end
    # end
  end
end
