require 'spec_helper'

describe "admin/pages#create", :type => :request do

  let :valid_data do
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
    }
  end
  let :json_body do
    data.to_json
  end

  let :admin do FactoryGirl.create(:admin) end

  describe "Successful create" do
    let :data do
      valid_data
    end

    describe "POST admin/pages" do
      it "returns 201 with the new address in the header 'Location'" do
        authenticated_json_post admin, "admin/pages", json_body

        expect(response.status).to eq(201)
        expect(response.headers["Location"]).to eq(admin_page_path( Page.find_by_url_slug( "test_slug" ) ) )
      end
    end
  end

  describe "failing creates" do
    describe 'required column omitted' do
      let :data do
        valid_data.deep_merge({data: {title: nil}})
      end

      describe "POST admin/pages" do
        it "redirects to admin page show path" do
          authenticated_json_post admin, "admin/pages", json_body
          expect(response.status).to eq(422)
          expect(response.body).to eq("{\"data\":{\"title\":{\"type\":\"required\",\"message\":\"can't be blank\"}}}")
        end
      end
      describe 'required content omitted' do
        let :data do
          valid_data.deep_merge({
            data: {
              contents: {
                main: {
                  data: {
                    body: nil
                  }
                }
              }
            }
          })
        end

        describe "POST admin/pages" do
          it "redirects to admin page show path" do
            authenticated_json_post admin, "admin/pages", json_body
            expect(response.status).to eq(422)
            expect(response.body).to be_json_eql("\"can't be blank\"").at_path("data/contents/main/data/body/message")
          end
        end
      end
    end

  end

  describe "not authenticated" do
    let :data do
      valid_data
    end

    it "should return not authorized" do
      json_post "admin/pages", json_body
      expect(response.status).to be(401)
    end
  end
end
