require 'spec_helper'


# example JSON output from request
# {
#   "links"=>
#   {
#     "self" => "/navigation/main"
#   },
#   "data"=>
#   [
#     {
#       "links" => {},
#       "data" => {
#         "name"=>"About",
#         "url" =>"/about",
#         "children" => [{
#           "links" => {},
#           "data" => {
#             "name" => "Services",
#             "url" => "/services",
#             "children" => []
#           }
#         }]
#       }
#     },
#     {
#       "links" => {},
#       "data" => {
#         "name" => "Yahoo",
#         "url" => "http://www.yahoo.com",
#         "children" => []
#       }
#     }
#   ]
# }

describe "main_menu#show" do
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
        "self" => "/navigation/main"
      },
      "data"=>
      [
        {
          "links" => {},
          "data" => {
            "name"=>"About",
            "url" =>"/about",
            "type" => "page",
            "children" => [{
              "links" => {},
              "data" => {
                "name" => "Services",
                "url" => "/services",
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
            "url" => "http://www.yahoo.com",
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
