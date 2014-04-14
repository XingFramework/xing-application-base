require 'spec_helper'

describe "contents/new" do
  before(:each) do
    assign(:content, stub_model(Content,
      :name => "MyString",
      :group => "MyString",
      :text => "MyText"
    ).as_new_record)
  end

  it "renders new content form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contents_path, "post" do
      assert_select "input#content_name[name=?]", "content[name]"
      assert_select "input#content_group[name=?]", "content[group]"
      assert_select "textarea#content_text[name=?]", "content[text]"
    end
  end
end
