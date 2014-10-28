require 'spec_helper'

describe "pages#update", :type => :request do
  let :main     do FactoryGirl.create(:content_block) end
  let :headline do FactoryGirl.create(:content_block, :body => 'the content') end
  let :styles   do FactoryGirl.create(:content_block, :content_type => 'text/css', :body => "h1 { text-align: center; }") end

  let! :page do
    FactoryGirl.create(:one_column_page,
      :title => "One Column Page Title",
      :page_contents => [  PageContent.new(:name => 'main', :content_block => main),
                           PageContent.new(:name => 'headline', :content_block => headline),
                           PageContent.new(:name => 'styles', :content_block => styles)]
    )
    #.tap do |pg|
      #expect(pg.contents['styles']['body']).to eq('h1 { text-align: center; }')
    #end
  end

  let :json_body do
    {
      data: {
        title: "New Title",
        contents: {
          main: {
            data: {
              body: 'Four score and <em>seven</em> years'
            }
          }
        }
      }
    }.to_json
  end

  describe "successful update" do
    describe "PUT admin/pages/:url_slug" do
      it "returns 200 and the serialized updated resource" do

        json_put "admin/pages/#{page.url_slug}", json_body


        expect(response.status).to eq(200)
        expect(response.body).to have_json_path("links")
        expect(response.body).to have_json_path("links/self")
        expect(response.body).to have_json_path("links/public")
        expect(response.body).to have_json_path("data")
        expect(response.body).to have_json_path("data/title")
        expect(response.body).to have_json_path("data/keywords")
        expect(response.body).to have_json_path("data/description")
        expect(response.body).to have_json_path("data/layout")
        expect(response.body).to have_json_path("data/contents")
        expect(response.body).to have_json_size(3).at_path("data/contents")
        expect(response.body).to be_json_eql("\"/admin/pages/#{page.url_slug}\"").at_path("links/self")
        expect(response.body).to be_json_eql("\"New Title\"").at_path("data/title")
        expect(response.body).to be_json_eql("\"#{admin_content_block_path(headline)}\"").at_path("data/contents/headline/links/self")
        expect(response.body).to be_json_eql("\"Four score and <em>seven</em> years\"").at_path("data/contents/main/data/body")

        # TODO:   see why style blocks are getting saved with blank body
        #expect(response.body).to
        #be_json_eql("\"#{styles.body}\"").at_path("data/contents/styles/data/body")
      end

      it "should update information" do
        expect do
          json_put "admin/pages/#{page.url_slug}", json_body
        end.to change { page.reload.title }.to("New Title")
      end

      it "should update content block information" do
        expect do
          json_put "admin/pages/#{page.url_slug}", json_body
        end.to change { page.reload.contents['main'].body }.to("Four score and <em>seven</em> years")
      end
    end
  end

  describe "failing update" do
    let :invalid_json do
      {
        data: {
          title: "New Title",
          contents: {
            main: {
              data: {
                body: ''
              }
            }
          }
        }
      }.to_json
    end

    describe "PUT admin/pages/:url_slug" do
      it "is a 422 with an error in response body" do
        json_put "admin/pages/#{page.url_slug}", invalid_json

        expect(response.status).to be(422)
        expect(response.body).to eq("{\"data\":{\"contents\":{\"main\":{\"data\":{\"body\":{\"type\":\"required\",\"message\":\"can't be blank\"}}}}}}")
      end
    end
  end
end
