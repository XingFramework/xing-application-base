require 'spec_helper'

describe "tutorials/edit" do
  before(:each) do
    @tutorial = assign(:tutorial, stub_model(Tutorial,
      :title => "MyString",
      :user_type => "MyString"
    ))
  end

  it "renders the edit tutorial form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tutorial_path(@tutorial), "post" do
      assert_select "input#tutorial_title[name=?]", "tutorial[title]"
      assert_select "input#tutorial_user_type[name=?]", "tutorial[user_type]"
    end
  end
end
