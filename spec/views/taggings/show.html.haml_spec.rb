require 'spec_helper'

describe "taggings/show" do
  before(:each) do
    @tagging = assign(:tagging, stub_model(Tagging,
      :tag_id => 1,
      :taggable_id => 2,
      :taggable_type => "Taggable Type",
      :tagger_id => 3,
      :tagger_type => "Tagger Type",
      :context => "Context"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Taggable Type/)
    rendered.should match(/3/)
    rendered.should match(/Tagger Type/)
    rendered.should match(/Context/)
  end
end
