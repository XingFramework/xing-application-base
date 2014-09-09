require 'spec_helper'


# example JSON output from request
# {"links"=>{
#    "self" => "pages/auto_gen_link_url_2",
#    "admin" => "admin/pages/auto_gen_link_url_2" },
#  "data"=>
#   {"title"=>"Title for page 2",
#    "keywords"=>nil,
#    "description"=>nil,
#    "layout"=>"",
#    "contents"=>
#     {"styles"=>
#       {"links"=>{"self"=>"/admin/content_blocks/6"},
#        "data"=>{"content_type"=>"text/css", "body"=>"uncleaned"}},
#      "headline"=>
#       {"links"=>{"self"=>"/admin/content_blocks/5"},
#        "data"=>{"content_type"=>"text/html", "body"=>"the content"}},
#      "main"=>
#       {"links"=>{"self"=>"/admin/content_blocks/4"},
#        "data"=>{"content_type"=>"text/html", "body"=>"foo bar"}}}}}

describe "pages#show" do
  let :main     do FactoryGirl.create(:content_block) end
  let :headline do FactoryGirl.create(:content_block, :body => 'the content') end
  let :styles   do FactoryGirl.create(:content_block, :content_type => 'text/css', :body => "more stuff") end

  let :page do
    FactoryGirl.create(:page,
      :page_contents => [  PageContent.new(:name => 'main', :content_block => main),
                           PageContent.new(:name => 'headline', :content_block => headline),
                           PageContent.new(:name => 'styles', :content_block => styles)]
    )
  end

  describe "GET /pages/:url_slug" do
    it "shows page as json" do
      json_get "/pages/#{page.url_slug}"

      expect(response).to be_success
      expect(response.body).to have_json_path("links")
      expect(response.body).to have_json_path("links/self")
      expect(response.body).to have_json_path("links/admin")
      expect(response.body).to have_json_path("data")
      expect(response.body).to have_json_path("data/title")
      expect(response.body).to have_json_path("data/keywords")
      expect(response.body).to have_json_path("data/description")
      expect(response.body).to have_json_path("data/layout")
      expect(response.body).to have_json_path("data/contents")
      expect(response.body).to have_json_size(3).at_path("data/contents")
      expect(JSON.parse(response.body)["links"]["self"]).to eq("/pages/#{page.url_slug}")
      expect(JSON.parse(response.body)["data"]["title"]).to eq(page.title)
      expect(JSON.parse(response.body)["data"]["contents"]["headline"]["links"]["self"]).to eq(admin_content_block_path(headline))
      expect(JSON.parse(response.body)["data"]["contents"]["styles"]["data"]["body"]).to eq(styles.body)
    end
  end
end
