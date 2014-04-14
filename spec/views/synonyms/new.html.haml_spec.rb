require 'spec_helper'

describe "synonyms/new" do
  before(:each) do
    assign(:synonym, stub_model(Synonym,
      :name => "MyString",
      :tag_id => 1
    ).as_new_record)
  end

  it "renders new synonym form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", synonyms_path, "post" do
      assert_select "input#synonym_name[name=?]", "synonym[name]"
      assert_select "input#synonym_tag_id[name=?]", "synonym[tag_id]"
    end
  end
end
