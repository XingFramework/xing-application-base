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
        it "should create the content blocks" do
          expect do
            mapper.save
          end.to change{ ContentBlock.count}.by(2)
          page = Page.last
          page.contents['main'].body.should     == 'Fourscore and seven years.'
          page.contents['headline'].body.should == 'The Gettysburg Address'

        end
      end

      describe "when extra content is provided" do
        let :invalid_data do
          valid_data.deep_merge({ :data => { :contents => {
            main:     { data: { body: "Fourscore and seven years." }},
            headline: { data: { body: "The Gettysburg Address" }},
            sidebar:  { data: { body: "See below for other famous speeches!" }}
          }}}
          )
        end

        let :json do
          invalid_data.to_json
        end

        it "should raise an error without saving anything" do
          expect do
            expect do
              mapper.save
            end.to raise_error(PageMapper::BadContentException)
          end.not_to change{ Page.count}
        end
      end
    end

  end


  describe "updating" do
    let :page do
      FactoryGirl.create(:one_column_page, :title => 'The Old Title')
    end

    let :mapper do
      PageMapper.new(json, page.url_slug)
    end

    describe "an attribute column" do
      let :json do
        { data: { title: "The New Title" } }.to_json
      end

      it "should update the desired column" do
        expect do
          mapper.save
        end.to change{ page.reload.title }.to("The New Title")
      end

      # is this too clever for its own good?  trying to avoid having to make
      # a new mapper and save it for each individual attribute
      it "should not update anything else" do
        unchanged_fields = [ :url_slug, :keywords, :description, :contents ]
        expect do
          mapper.save
        end.not_to change {
          page.reload
          unchanged_fields.map do |key|
            [ key, page.send(key) ]
          end
        }

      end
    end

    describe "a content body" do
      let :json do
        { data: { contents: { main: { data: { body: "The New Body" }}}}}.to_json
      end

      it "should update the desired column" do
        expect do
          mapper.save
        end.to change{ page.reload.contents['main'].body }.to("The New Body")
      end

      # is this too clever for its own good?  trying to avoid having to make
      # a new mapper and save it for each individual attribute
      it "should not update anything else" do
        unchanged_fields = [ :url_slug, :keywords, :description, :title ]
        expect do
          mapper.save
        end.not_to change {
          page.reload
          unchanged_fields.map do |key|
            [ key, page.send(key) ]
          end
        }

      end
    end



  end
end
