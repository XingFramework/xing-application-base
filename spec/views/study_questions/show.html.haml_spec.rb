require 'spec_helper'

describe "study_questions/show" do
  before(:each) do
    @study_question = assign(:study_question, stub_model(StudyQuestion,
      :text => "MyText",
      :study_id => 1,
      :attachment_file_name => "Attachment File Name",
      :attachment_content_type => "Attachment Content Type",
      :attachment_file_size => 2,
      :embed => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/Attachment File Name/)
    rendered.should match(/Attachment Content Type/)
    rendered.should match(/2/)
    rendered.should match(/MyText/)
  end
end
