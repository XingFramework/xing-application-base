require 'spec_helper'

describe "taggings/edit" do
  before(:each) do
    @tagging = assign(:tagging, stub_model(Tagging,
      :tag_id => 1,
      :taggable_id => 1,
      :taggable_type => "MyString",
      :tagger_id => 1,
      :tagger_type => "MyString",
      :context => "MyString"
    ))
  end

  it "renders the edit tagging form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tagging_path(@tagging), "post" do
      assert_select "input#tagging_tag_id[name=?]", "tagging[tag_id]"
      assert_select "input#tagging_taggable_id[name=?]", "tagging[taggable_id]"
      assert_select "input#tagging_taggable_type[name=?]", "tagging[taggable_type]"
      assert_select "input#tagging_tagger_id[name=?]", "tagging[tagger_id]"
      assert_select "input#tagging_tagger_type[name=?]", "tagging[tagger_type]"
      assert_select "input#tagging_context[name=?]", "tagging[context]"
    end
  end
end
