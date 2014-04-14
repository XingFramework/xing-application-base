require 'spec_helper'

describe "researcher_interests/show" do
  before(:each) do
    @researcher_interest = assign(:researcher_interest, stub_model(ResearcherInterest,
      :first_name => "First Name",
      :last_name => "Last Name",
      :email => "Email",
      :phone => "Phone",
      :company_name => "Company Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Email/)
    rendered.should match(/Phone/)
    rendered.should match(/Company Name/)
  end
end
