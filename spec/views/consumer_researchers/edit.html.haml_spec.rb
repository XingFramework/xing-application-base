require 'spec_helper'

describe "consumer_researchers/edit" do
  before(:each) do
    @consumer_researcher = assign(:consumer_researcher, stub_model(ConsumerResearcher,
      :consumer_id => 1,
      :researcher_id => 1
    ))
  end

  it "renders the edit consumer_researcher form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", consumer_researcher_path(@consumer_researcher), "post" do
      assert_select "input#consumer_researcher_consumer_id[name=?]", "consumer_researcher[consumer_id]"
      assert_select "input#consumer_researcher_researcher_id[name=?]", "consumer_researcher[researcher_id]"
    end
  end
end
