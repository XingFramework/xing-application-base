require 'spec_helper'

describe "pages#update", :type => :request do
  let :main     do FactoryGirl.create(:content_block) end
  let :headline do FactoryGirl.create(:content_block, :body => 'the content') end
  let :styles   do FactoryGirl.create(:content_block, :content_type => 'text/css', :body => "more stuff") end

  let! :page do
    FactoryGirl.create(:one_column_page,
      :title => "One Column Page Title",
      :page_contents => [  PageContent.new(:name => 'main', :content_block => main),
                           PageContent.new(:name => 'headline', :content_block => headline),
                           PageContent.new(:name => 'styles', :content_block => styles)]
    )
  end

  let :json_body do
    {
      data: {
        title: "New Title",
        keywords: "test keywords",
        description: "test description and blah blah blah",
        layout: "one_column",

        published: true,
        publish_start: nil,
        publish_end: nil,

        contents: {
          main: {
            data: {
              body: 'Four score and <em>seven</em> years'
            }
          },
          headline: {
            data: {
              body: 'The Gettysburg Address'
            }
          },
          styles: {
            data: {
              body: 'p { font-weight: bold; }'
            }
          }
        }
      }
    }.to_json
  end

  describe "PUT admin/pages/:url_slug" do
    it "redirects to admin page show path" do

      json_put "admin/pages/#{page.url_slug}", json_body

      expect(response).to redirect_to( admin_page_path( page ) )
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
