require 'spec_helper'

describe "researcher_interests/index" do
  before(:each) do
    assign(:researcher_interests, [
      stub_model(ResearcherInterest,
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :phone => "Phone",
        :company_name => "Company Name"
      ),
      stub_model(ResearcherInterest,
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :phone => "Phone",
        :company_name => "Company Name"
      )
    ])
  end

  it "renders a list of researcher_interests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Company Name".to_s, :count => 2
  end
end
