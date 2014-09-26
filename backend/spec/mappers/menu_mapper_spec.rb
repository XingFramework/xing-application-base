require 'spec_helper'

describe MenuMapper do
  let :request_data do
    {
      data: {
      name: "Test Root",
      children: [
        {
          links: {},
          data: {
          name: 'One',
          path: path,
          type: 'raw_url'
        }
        },
          {
          links: {},
          data: {
          name: 'Two',
          path: path,
          type: 'raw_url'
        }
        },
          {
          links: {},
          data: {
          name: 'Three',
          path: path,
          type: 'raw_url'
    } } ] } }
  end

  let :path do
    'https://www.owasp.org/index.php/Main_Page'
  end

  let :json do
    request_data.to_json
  end

  let :mapper do
    MenuMapper.new(json)
  end

  describe "saving a new menu" do
    it "should save without error" do
      expect{
        mapper.save
      }.not_to raise_error
    end

    it "should be able to return the menu item with correct attributes" do
      Rails.logger.warn{ "Beginning test" }
      mapper.save
      expect(mapper.menu_root).to be_a(MenuItem)
      expect(mapper.menu_root).to be_persisted
      expect(mapper.menu_root).to be_root
      expect(mapper.menu_root.children.first.path).to eq(path)
      expect(mapper.menu_root.children.first.page).to be_nil
      expect(mapper.menu_root.children[0].name).to eq("One")
      expect(mapper.menu_root.children[1].name).to eq("Two")
      expect(mapper.menu_root.children[2].name).to eq("Three")
    end
  end

  describe "reordering an existing menu" do
    let :second_data do
      {
        data: {
        name: "Test Root",
        children: [
          {
        links: {},
        data: {
        name: 'One',
        path: path,
        type: 'raw_url'
      }
      },
        {
        links: {},
        data: {
        name: 'Three',
        path: path,
        type: 'raw_url'
      }
      },
        {
        links: {},
        data: {
        name: 'Two',
        path: path,
        type: 'raw_url'
      } } ] } }
    end

    it "should save reordered menu" do
      first = MenuMapper.new(json)
      first.save
      menu_root = first.menu_root

      expect(menu_root.children[0].name).to eq("One")
      expect(menu_root.children[1].name).to eq("Two")
      expect(menu_root.children[2].name).to eq("Three")

      second = MenuMapper.new(second_data.to_json, menu_root.id)
      second.save
      menu_root.reload

      expect(menu_root.children[0].name).to eq("One")
      expect(menu_root.children[1].name).to eq("Three")
      expect(menu_root.children[2].name).to eq("Two")
    end
  end

  describe "updating an existing menu" do
    let! :menu_root do
      FactoryGirl.create(:main_menu_root)
    end

    let :mapper do
      MenuMapper.new(json, menu_root.id)
    end

    it "should be able to return the menu item with correct attributes" do
      mapper.save
      expect(mapper.menu_root).to be_a(MenuItem)
      expect(mapper.menu_root).to be_persisted
      expect(mapper.menu_root).to be_root
      expect(mapper.menu_root.children.first.path).to eq(path)
      expect(mapper.menu_root.children.first.page).to be_nil
    end
  end
end
