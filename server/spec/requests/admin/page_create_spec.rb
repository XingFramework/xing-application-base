require 'spec_helper'

describe "pages#create", :type => :request do

  let :json_body do
    {
      data: {
        url_slug: "test_slug",
        title: "test_title",
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

  describe "POST admin/pages" do
    it "redirects to admin page show path" do
      json_post "admin/pages", json_body

      expect(response).to redirect_to( admin_page_path( Page.find_by_url_slug( "test_slug" ) ) )
    end
  end
end
