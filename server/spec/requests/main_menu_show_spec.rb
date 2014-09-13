require 'spec_helper'

describe "menu#show" do
  let (:main_menu) { MenuItem.roots.where(:name => "Main Menu").first }
  let (:services_page) { FactoryGirl.create(:page, :url_slug => "services") }
  let (:about_page) { FactoryGirl.create(:page, :url_slug => "about") }
  let (:about) { FactoryGirl.create(:menu_item, :page => about_page, :name => "About", :parent => main_menu) }
  let! (:services) { FactoryGirl.create(:menu_item, :page => services_page, :name => "Services", :parent => about) }
  let! (:yahoo) { FactoryGirl.create(:menu_item, :path => "http://www.yahoo.com", :name => "Yahoo", :parent => main_menu) }

  let (:expected_result) {
    {
      "links"=>
      {
        "self" => "/menus/#{main_menu.id}"
      },
      "data"=>
      [
        {
          "links" => {},
          "data" => {
            "name"=>"About",
            "path" =>"/about",
            "type" => "page",
            "children" => [{
              "links" => {},
              "data" => {
                "name" => "Services",
                "path" => "/services",
                "type" => "page",
                "children" => []
              }
            }]
          }
        },
        {
          "links" => {},
          "data" => {
            "name" => "Yahoo",
            "path" => "http://www.yahoo.com",
            "type" => "raw_url",
            "children" => []
          }
        }
      ]
    }
  }

  describe "GET /navigation/main" do
    it "shows page as json" do
      json_get "/navigation/main"

      expect(response).to be_success
      expect(response.body).to be_json_eql(expected_result.to_json)
    end
  end
end
