require 'spec_helper'

describe Menu do

  describe 'list' do
    let! :root_1 do FactoryGirl.build(:menu_item, :parent => nil, :name => 'Menu 1') end
    let! :root_2 do FactoryGirl.build(:menu_item, :parent => nil, :name => 'Menu 2') end
    let! :child_1 do FactoryGirl.build(:menu_item, :parent => root_1, :name => 'Child 1') end
    let! :child_2 do FactoryGirl.build(:menu_item, :parent => child_1, :name => 'Child 2') end

    it "should have four menu items" do
      expect(MenuItem.count).to eq(4)
    end

    it "should find two menus" do
      expect(Menu.list.length).to eq(2)
      Menu.list.each do |mm|
        expect(mm).to be_a(Menu)
      end
    end
  end

end
