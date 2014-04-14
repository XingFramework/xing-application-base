require 'spec_helper'

describe "study_questions/index" do
  before(:each) do
    assign(:study_questions, [
      stub_model(StudyQuestion,
        :text => "MyText",
        :study_id => 1,
        :attachment_file_name => "Attachment File Name",
        :attachment_content_type => "Attachment Content Type",
        :attachment_file_size => 2,
        :embed => "MyText"
      ),
      stub_model(StudyQuestion,
        :text => "MyText",
        :study_id => 1,
        :attachment_file_name => "Attachment File Name",
        :attachment_content_type => "Attachment Content Type",
        :attachment_file_size => 2,
        :embed => "MyText"
      )
    ])
  end

  it "renders a list of study_questions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Attachment File Name".to_s, :count => 2
    assert_select "tr>td", :text => "Attachment Content Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
