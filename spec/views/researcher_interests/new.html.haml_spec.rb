require 'spec_helper'

describe "researcher_interests/new" do
  before(:each) do
    assign(:researcher_interest, stub_model(ResearcherInterest,
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :company_name => "MyString"
    ).as_new_record)
  end

  it "renders new researcher_interest form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", researcher_interests_path, "post" do
      assert_select "input#researcher_interest_first_name[name=?]", "researcher_interest[first_name]"
      assert_select "input#researcher_interest_last_name[name=?]", "researcher_interest[last_name]"
      assert_select "input#researcher_interest_email[name=?]", "researcher_interest[email]"
      assert_select "input#researcher_interest_phone[name=?]", "researcher_interest[phone]"
      assert_select "input#researcher_interest_company_name[name=?]", "researcher_interest[company_name]"
    end
  end
end
