require 'spec_helper'

require 'spec_helper'

describe "admin/menus#index", :type => :request do


  describe "GET admin/menus" do
    it "shows page as json" do
      json_get "admin/menus"

#{
  #links; {
    #self: "/admin/menus"
  #},
  #data: [
    #{ links: {
        #self: 'admin/menus/:id1'
      #},
      #data: {
        #name: 'Menu 1'
      #}
    #},
    #{ links: {
        #self: 'admin/menus/:id2'
      #},
      #data: {
        #name: 'Menu 2'
      #}
    #},
    #{ links: {
        #self: 'admin/menus/:id3'
      #},
      #data: {
        #name: 'Menu 3'
      #}
    #}
  #]
#}

      puts "---"
      puts response.body
      puts "---"
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

