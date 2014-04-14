require 'spec_helper'

describe "taggings/index" do
  before(:each) do
    assign(:taggings, [
      stub_model(Tagging,
        :tag_id => 1,
        :taggable_id => 2,
        :taggable_type => "Taggable Type",
        :tagger_id => 3,
        :tagger_type => "Tagger Type",
        :context => "Context"
      ),
      stub_model(Tagging,
        :tag_id => 1,
        :taggable_id => 2,
        :taggable_type => "Taggable Type",
        :tagger_id => 3,
        :tagger_type => "Tagger Type",
        :context => "Context"
      )
    ])
  end

  it "renders a list of taggings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Taggable Type".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Tagger Type".to_s, :count => 2
    assert_select "tr>td", :text => "Context".to_s, :count => 2
  end
end
