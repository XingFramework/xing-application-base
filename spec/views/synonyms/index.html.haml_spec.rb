require 'spec_helper'

describe "synonyms/index" do
  before(:each) do
    assign(:synonyms, [
      stub_model(Synonym,
        :name => "Name",
        :tag_id => 1
      ),
      stub_model(Synonym,
        :name => "Name",
        :tag_id => 1
      )
    ])
  end

  it "renders a list of synonyms" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
