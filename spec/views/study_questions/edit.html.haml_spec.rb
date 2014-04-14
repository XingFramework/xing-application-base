require 'spec_helper'

describe "study_questions/edit" do
  before(:each) do
    @study_question = assign(:study_question, stub_model(StudyQuestion,
      :text => "MyText",
      :study_id => 1,
      :attachment_file_name => "MyString",
      :attachment_content_type => "MyString",
      :attachment_file_size => 1,
      :embed => "MyText"
    ))
  end

  it "renders the edit study_question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", study_question_path(@study_question), "post" do
      assert_select "textarea#study_question_text[name=?]", "study_question[text]"
      assert_select "input#study_question_study_id[name=?]", "study_question[study_id]"
      assert_select "input#study_question_attachment_file_name[name=?]", "study_question[attachment_file_name]"
      assert_select "input#study_question_attachment_content_type[name=?]", "study_question[attachment_content_type]"
      assert_select "input#study_question_attachment_file_size[name=?]", "study_question[attachment_file_size]"
      assert_select "textarea#study_question_embed[name=?]", "study_question[embed]"
    end
  end
end
