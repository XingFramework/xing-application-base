require 'spec_helper'

describe "consumer_researchers/new" do
  before(:each) do
    assign(:consumer_researcher, stub_model(ConsumerResearcher,
      :consumer_id => 1,
      :researcher_id => 1
    ).as_new_record)
  end

  it "renders new consumer_researcher form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", consumer_researchers_path, "post" do
      assert_select "input#consumer_researcher_consumer_id[name=?]", "consumer_researcher[consumer_id]"
      assert_select "input#consumer_researcher_researcher_id[name=?]", "consumer_researcher[researcher_id]"
    end
  end
end
