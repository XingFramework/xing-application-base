require 'spec_helper'

describe "synonyms/edit" do
  before(:each) do
    @synonym = assign(:synonym, stub_model(Synonym,
      :name => "MyString",
      :tag_id => 1
    ))
  end

  it "renders the edit synonym form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", synonym_path(@synonym), "post" do
      assert_select "input#synonym_name[name=?]", "synonym[name]"
      assert_select "input#synonym_tag_id[name=?]", "synonym[tag_id]"
    end
  end
end
