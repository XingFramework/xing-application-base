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
            mapper.perform_mapping
          end.not_to change{ ContentBlock.count}
          mapper.content_block.body.should eq 'foo bar'
        end

        it "should be able to return the content block without it being persisted" do
          mapper.perform_mapping
          expect(mapper.content_block).to be_a(ContentBlock)
          expect(mapper.content_block).not_to be_persisted
        end
      end
    end
  end
end
