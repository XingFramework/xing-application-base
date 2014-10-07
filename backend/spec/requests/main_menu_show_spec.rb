require 'spec_helper'

describe "menu#show", :type => :request do
  let (:main_menu) { MenuItem.roots.where(:name => "Main Menu").first }
  let (:services_page) { FactoryGirl.create(:page, :url_slug => "services") }
  let (:about_page) { FactoryGirl.create(:page, :url_slug => "about") }
  let (:about) { FactoryGirl.create(:menu_item, :page => about_page, :name => "About", :parent => main_menu) }
  let! (:services) { FactoryGirl.create(:menu_item, :page => services_page, :name => "Services", :parent => about) }
  let! (:yahoo) { FactoryGirl.create(:menu_item, :path => "http://www.yahoo.com", :name => "Yahoo", :parent => main_menu) }

  let (:expected_result) {
    {
      "links"=> {
        "self" => "/menus/#{main_menu.id}",
      },
      "data"=> {
          "name" => "Main Menu",
          "path" => "#",
          "type" => "raw_url",
          "children" => [
          {
            "links" => {},
            "data" => {
              "type" => "page",
              "name"=>"About",
              "page" => { "links" => { "self" => "/pages/about" }},
              "children" => [{
                "links" => {},
                "data" => {
                  "type" => "page",
                  "name" => "Services",
                  "page" => { "links" => { "self" => "/pages/services" }},
                  "children" => []
                }
              }]
            }
          },
          {
            "links" => {},
            "data" => {
              "type" => "raw_url",
              "name" => "Yahoo",
              "path" => "http://www.yahoo.com",
              "children" => []
            }
          }
        ]
      }
    }
  }

  describe "GET /navigation/main" do
    it "shows page as json" do
      json_get "/navigation/main"

      expect(response).to be_success
      expect(response.body).to be_json_eql(expected_result.to_json)
    end
  end

  describe "GET /menus/:id" do
    it "shows page as json" do
      json_get "menus/#{main_menu.id}"

      expect(response).to be_success
      expect(response.body).to be_json_eql(expected_result.to_json)
    end
  end
end

describe "menus#index", :type => :request do
  describe "GET admin/menus" do
    it "shows page as json" do
      json_get "menus"

      expect(response).to be_success
      expect(response.body).to have_json_path("links")
      expect(response.body).to have_json_path("links/self")
      expect(response.body).to have_json_path("data")

      expect(response.body).to have_json_path("data/0/data/name")
      expect(response.body).to have_json_path("data/1/data/name")
      expect(JSON.parse(response.body)['data'].length).to eq(2)
    end
  end
end
