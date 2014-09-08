require 'spec_helper'

describe Menu do
  let :root_1 do FactoryGirl.create(:menu_item, :parent => nil, :name => 'Menu 1') end
  let :root_2 do FactoryGirl.create(:menu_item, :parent => nil, :name => 'Menu 2') end
  let :child_1 do FactoryGirl.create(:menu_item, :parent => root_1, :name => 'Child 1') end
  let :child_2 do FactoryGirl.create(:menu_item, :parent => child_1, :name => 'Child 2') end
   let :menu do Menu.new(item) end

  describe 'list' do

    before do
      MenuItem.delete_all # seeds creates two root menu items
      root_1; root_2; child_1; child_2
    end

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

  describe 'instantiation' do

    describe "with a root item" do
      let :item do root_1 end

      it "should result in a Menu with that MenuItem stored" do
        expect(menu).to           be_a(Menu)
        expect(menu.menu_item).to eq(item)
      end
    end
    describe "with a non-root item" do
      let :item do child_1 end

      it "should result in a Menu with that MenuItem stored" do
        expect{ menu }.to raise_error
      end
    end
  end

  describe 'delegation' do
    let :item do root_1 end

    it "should delegate proper methods" do
      [:name, :parent ].each do |method|
        root_1.should_receive(method)
        menu.send(method)
      end
    end

  end


  describe "tree" do
    let :item do root_1 end

    before do
      MenuItem.delete_all  # seeds creates two root menu items
      root_1; root_2; child_1; child_2
    end

    it "should have the elements of the tree" do
      menu.reload
      expect(menu.tree).to include(root_1, child_1, child_2)
    end

    it "should not have items outside the tree" do
      menu.reload
      expect(menu.tree).not_to include(root_2)
    end
  end

end
