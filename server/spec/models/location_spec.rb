# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  path       :string(255)
#  parent_id  :integer
#  lft        :integer
#  rgt        :integer
#  page_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Location do
  describe "mass assignment" do
     it "should mass assign name and path" do
       location = Location.new(:name => 'foo', :path => 'bar' )
       location.name.should == 'foo'
       location.path.should == 'bar'
     end
   end

   describe "validations" do
     describe "presence" do
       it "should not create a location with blank name" do
         FactoryGirl.build(:location, :name => nil).should_not be_valid
       end
      it "should allow alocation with a name" do
        FactoryGirl.build(:location, :name => 'foo').should be_valid
      end
     end
   end

   describe "resolved path" do
     it "should return the page permalink if there's a page foreign key" do
       page = FactoryGirl.build(:page, :permalink => 'some/address')
       loc = FactoryGirl.build(:location, :path => 'foobar')
       loc.page = page
       loc.save!
       loc.resolved_path.should == "/" + page.permalink
     end

     it "should return the location's path if there's no page foreign key" do
       loc = FactoryGirl.build(:location, :path => 'foobar')
       loc.resolved_path.should == "/" + 'foobar'
     end
   end
end
