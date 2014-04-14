require 'spec_helper'

describe "tutorials/new" do
  before(:each) do
    assign(:tutorial, stub_model(Tutorial,
      :title => "MyString",
      :user_type => "MyString"
    ).as_new_record)
  end

  it "renders new tutorial form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tutorials_path, "post" do
      assert_select "input#tutorial_title[name=?]", "tutorial[title]"
      assert_select "input#tutorial_user_type[name=?]", "tutorial[user_type]"
    end
  end
end
