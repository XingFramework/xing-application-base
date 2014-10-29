require 'spec_helper'

describe "menu_items#update", :type => :request do

  let! :menu_item do
    FactoryGirl.create(:menu_item)
  end

  let :json_body do
    {
      data: {
        name: 'New Name'
      }
    }.to_json
  end

  let :admin do FactoryGirl.create(:admin) end

  describe "Successful update"do
    describe "PUT admin/menu_items/:id" do
      it "is a 200 success including the serialized object" do

        authenticated_json_put admin, "admin/menu_items/#{menu_item.id}", json_body

        expect(response).to be_success
        expect(response.body).to     have_json_path("links")
        expect(response.body).to     have_json_path("links/self")
        expect(response.body).to     have_json_path("data")
        expect(response.body).to     have_json_path("data/name")
        expect(response.body).to     have_json_path("data/path")
        expect(response.body).not_to have_json_path("data/page")
        expect(response.body).to     have_json_path("data/parent_id")

        expect(response.body).to be_json_eql("\"#{routes.admin_menu_item_path(menu_item)}\"").at_path('links/self')
        expect(response.body).to be_json_eql("\"New Name\"").at_path("data/name")

      end

      it "should update information" do
        expect do
          authenticated_json_put admin, "admin/menu_items/#{menu_item.id}", json_body
        end.to change { menu_item.reload.name }.to("New Name")
      end
    end
  end

  describe "failing update" do
    describe 'required information omitted' do
      let :invalid_json do
        {
          data: {
            name: nil
          }
        }.to_json
      end

      describe "PUT admin/menu_items/:id" do
        it "is a 422 with an error in response body" do
          authenticated_json_put admin, "admin/menu_items/#{menu_item.id}", invalid_json

          expect(response.status).to be(422)
          expect(response.body).to be_json_eql("\"can't be blank\"").at_path("data/name/message")
        end
      end
    end
  end

  describe "not authenticated" do
    it "should return not authorized" do
      json_put "admin/menu_items/#{menu_item.id}", json_body
      expect(response.status).to be(401)
    end
  end

end
