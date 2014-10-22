require 'spec_helper'

describe ContentBlockMapper, :type => :mapper do
  describe "saving content" do
    describe "assigns values" do
      let :mapper do
        ContentBlockMapper.new(json)
      end

      let :valid_data do
        { data: {
            body: 'foo bar'
        }}
      end

      let :invalid_data do
        { data: {
            body: ''
        }}
      end

      describe "content block is valid" do
        let :json do
          valid_data.to_json
        end

        # This mapper never saves, it only builds and the PageMapper saves the ContentBlock
        it "should build the content block" do
          expect do
            mapper.build
          end.not_to change{ ContentBlock.count}
          mapper.content_block.body.should eq 'foo bar'
        end

        it "should be able to return the content block without it being persisted" do
          mapper.build
          expect(mapper.content_block).to be_a(ContentBlock)
          expect(mapper.content_block).not_to be_persisted
        end
      end

      describe "content block is invalid" do
        let :json do
          invalid_data.to_json
        end

        # This mapper never saves, it only builds and the PageMapper saves the ContentBlock
        it "should build the content block" do
          expect do
            mapper.build
          end.not_to change{ ContentBlock.count}
        end

        it "should be able to return the content block without it being persisted" do
          mapper.build
          expect(mapper.content_block).to be_a(ContentBlock)
          expect(mapper.content_block).not_to be_persisted
        end

        it "should return an error hash" do
          mapper.build
          expect(mapper.errors).to eq(
            {:data=>{:body=>{:type=>:required, :message=>"can't be blank"}}}
          )
        end
      end
    end
  end
end