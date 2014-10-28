require 'spec_helper'

describe "admin/menu_items#create", :type => :request do

  let :valid_data do
    {
      data: {
        name: 'Services',
        path: 'https://www.owasp.org/index.php/Main_Page',
        type: 'raw_url'
      }
    }
  end

  let :json_body do
    data.to_json
  end

  describe "Successful create" do
    let :data do
      valid_data
    end

    describe "POST admin/menu_items" do
      it "returns 201 with the new address in the header 'Location'" do
        json_post "admin/menu_items", json_body

        expect(response.status).to eq(201)
        expect(response.headers["Location"]).to eq(admin_menu_item_path( MenuItem.find_by_name( 'Services' ) ) )
      end
    end
  end

  describe "failing creates" do
    describe 'required column omitted' do
      let :data do
        valid_data.deep_merge({data: {name: nil}})
      end

      describe "POST admin/menu_items" do
        it "redirects to admin menu item show path" do
          json_post "admin/menu_items", json_body
          expect(response.status).to eq(422)
          expect(response.body).to eq("{\"data\":{\"name\":{\"type\":\"required\",\"message\":\"can't be blank\"}}}")
        end
      end

      describe 'required information omitted' do
        let :data do
          valid_data.deep_merge({data: {path: nil}})
        end

        describe "POST admin/menu_items" do
          it "redirects to admin menu item show path" do
            json_post "admin/menu_items", json_body
            expect(response.status).to eq(422)
            expect(response.body).to eq("{\"data\":{\"path\":{\"type\":\"required\",\"message\":\"This field is required\"}}}")
        end
        end
      end
    end

  end
end
