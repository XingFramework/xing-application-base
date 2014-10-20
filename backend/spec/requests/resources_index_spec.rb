require 'spec_helper'


# example JSON output from request
# {"links"=>{
#    lists of route names and their uri templates
#    (e.g "page" => "/pages/{url_slug}")
#   },
#  "data"=>
#   {}

describe "resources#index", :type => :request do

  describe "GET /resources" do
    it "shows route templates asjson" do
      json_get "/resources"

      expect(response).to be_success
      expect(response.body).to be_json_eql("\"/pages/{url_slug}\"").at_path("links/page")
      expect(response.body).to be_json_eql("\"/menus/{id}\"").at_path("links/menu")

    end
  end
end
