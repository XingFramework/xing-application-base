require 'spec_helper'

describe MenuItemMapper, :type => :mapper do

  let! :menu_item do
    FactoryGirl.create(:menu_item)
  end

  describe "saving with a forced parent_id" do
    let :mapper do
      MenuItemMapper.new(json).tap do |mapper|
        mapper.parent_id = menu_item.id
      end
    end

    let :page do
      FactoryGirl.create(:page)
    end

    let :valid_data do
      {
        data: {
          name: 'Services',
          path: 'https://www.owasp.org/index.php/Main_Page',
          type: 'raw_url',
          parent_id: 666
        }
      }
    end

    let :json do
      valid_data.to_json
    end

    it "should be able to return the menu item with correct attributes" do
      mapper.save
      expect(mapper.menu_item).to be_a(MenuItem)
      expect(mapper.menu_item).to be_persisted
      expect(mapper.menu_item.path).to eq(valid_data[:data][:path])
      expect(mapper.menu_item.page).to be_nil
      expect(mapper.menu_item.parent).to eq(menu_item)
    end
  end

  describe "saving menu item" do
    let :mapper do
      MenuItemMapper.new(json)
    end

    let :page do
      FactoryGirl.create(:page)
    end

    let :valid_data do
      {
        data: {
          name: 'Services',
          path: 'https://www.owasp.org/index.php/Main_Page',
          type: 'raw_url',
          parent_id: menu_item.id
        }
      }
    end

    describe "for a menu item with external link" do

      let :json do
        valid_data.to_json
      end

      it "should create the menu item" do
        expect do
          mapper.save
        end.to change{ MenuItem.count}.by(1)
        expect(MenuItem.last.name).to eq('Services')
      end

      it "should be able to return the menu item with correct attributes" do
        mapper.save
        expect(mapper.menu_item).to be_a(MenuItem)
        expect(mapper.menu_item).to be_persisted
        expect(mapper.menu_item.path).to eq(valid_data[:data][:path])
        expect(mapper.menu_item.page).to be_nil
        expect(mapper.menu_item.parent).to eq(menu_item)
      end

      describe "with missing name" do
        let :invalid_data do
          {
            data: {
              name: nil,
              path: 'https://www.owasp.org/index.php/Main_Page',
              type: 'raw_url',
              parent_id: menu_item.id
            }
          }
        end

        let :json do
          invalid_data.to_json
        end

        it "should add to error hash without saving anything" do
          expect do
            mapper.save
          end.not_to change{ MenuItem.count }
          expect(mapper.errors).to eq(
            {:data=>{:name=>{:type=>"required", :message=>"can't be blank"}}}
          )
        end
      end

      describe "with missing url" do
        let :invalid_data do
          {
            data: {
              name: 'Services',
              path: nil,
              type: 'raw_url',
              parent_id: menu_item.id
            }
          }
        end

        let :json do
          invalid_data.to_json
        end

        it "should add to error hash without saving anything" do
          expect do
            Rails.logger.warn{ "Beginning save" }
            mapper.save
          end.not_to change{ MenuItem.count }
          expect(mapper.errors).to eq(
            {:data=>{:path=>{:type=>"required", :message=>"This field is required"}}}
          )
        end
      end
    end

    describe "for menu item with page link" do
      let :valid_data do
        {
          data: {
            name: 'Services',
            page: { links: { self: "/pages/#{page.url_slug}" } },
            type: 'page'
          }
        }
      end

      let :json do
        valid_data.to_json
      end

      it "should save correct attributes to the menu item" do
        mapper.save
        expect(mapper.menu_item.page).to eq(page)
        expect(mapper.menu_item.path).to be_nil
      end

      describe "with missing page url" do
        let :invalid_data do
          {
            data: {
              name: 'Services',
              page: { links: {  } },
              type: 'page'
            }
          }
        end

        let :json do
          invalid_data.to_json
        end

        it "should add to error hash without saving anything" do
          expect do
              mapper.save
          end.not_to change{ MenuItem.count}
          expect(mapper.errors).to eq(
            {:data=>{:page=>{:type=>"required", :message=>"This field is required"}}}
          )
        end
      end
    end
  end

  describe "updating" do
    let :mapper do
      MenuItemMapper.new(json, menu_item.id)
    end

    describe "an attribute column" do
      let :json do
        { data: { name: 'New Menu Name'} }.to_json
      end

      it "should update the desired column" do
        expect do
          mapper.save
        end.to change{ menu_item.reload.name }.to("New Menu Name")
      end

      it "should not update anything else" do
        unchanged_fields = [ :path, :page_id, :parent_id ]
        expect do
          mapper.save
        end.not_to change {
          menu_item.reload
          unchanged_fields.map do |key|
            [ key, menu_item.send(key) ]
          end
        }
      end

      it "should be able to return the menu item" do
        mapper.save
        expect(mapper.menu_item).to eq(menu_item)
        expect(mapper.menu_item).to be_persisted
      end
    end
  end
end
