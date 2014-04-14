require 'spec_helper'

describe "contents/edit" do
  before(:each) do
    @content = assign(:content, stub_model(Content,
      :name => "MyString",
      :group => "MyString",
      :text => "MyText"
    ))
  end

  it "renders the edit content form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_path(@content), "post" do
      assert_select "input#content_name[name=?]", "content[name]"
      assert_select "input#content_group[name=?]", "content[group]"
      assert_select "textarea#content_text[name=?]", "content[text]"
    end
  end
end
