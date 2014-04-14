require 'spec_helper'

describe "synonyms/show" do
  before(:each) do
    @synonym = assign(:synonym, stub_model(Synonym,
      :name => "Name",
      :tag_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end
