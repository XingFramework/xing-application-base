require 'spec_helper'

describe PageMapper do
  describe "saving content" do
    describe "for a page with two content blocks" do

      let :mapper do
        PageMapper.new(json)
      end

      before do
        Page.stub(:content_format).and_return(format)
      end

      let :format do
        [{ :name         => 'headline',
           :content_type => 'text/html'
        },
        {  :name         => 'main',
           :content_type => 'text/html'
        }]
      end

      let :valid_data do
        { data: {
          title:    'foo bar',
          keywords: 'foo, bar',
          contents: {
            main:     { data: { body: "Fourscore and seven years." }},
            headline: { data: { body: "The Gettysburg Address" }}
          }
        }}
      end

      describe "when the passed content matches the specs" do
        let :json do
          valid_data.to_json
        end

        it "should create the page" do
          expect do
            mapper.save
          end.to change{ Page.count}.by(1)
          Page.last.title.should eq 'foo bar'
        end
        it "should create the content blocks"
      end

      describe "when extra content is provided" do
        let :invalid_data do
          valid_data[:contents] =  {
            main:     { data: { body: "Fourscore and seven years." }},
            headline: { data: { body: "The Gettysburg Address" }}
          }
        end
        let :json do
          invalid_data.to_json
        end
        it "shouldn't create anything"
        it "should raise an error"
      end
    end

  end
end

