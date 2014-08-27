require 'spec_helper'


describe ApplicationHelper do

  describe "location path" do
    describe "when attached to page" do
      before(:each) do
        @loc = FactoryGirl.create(:location_with_page)
      end

      it "uses page permalink" do
        helper.loc_path(@loc).should == "/" + @loc.page.permalink
      end
    end

    describe "when not attached to page" do
      before(:each) do
        @loc = FactoryGirl.create(:location_without_page)
      end

      it "uses loc.path" do
        helper.loc_path(@loc).should == @loc.path
      end
    end
  end
end
