require 'spec_helper'

describe "credit_cards/index" do
  before(:each) do
    assign(:credit_cards, [
      stub_model(CreditCard,
        :researcher_id => 1,
        :first_name => "First Name",
        :last_name => "Last Name",
        :number => "Number",
        :month => "Month",
        :year => "Year",
        :ctype => "Ctype",
        :cvv => "Cvv",
        :address1 => "Address1",
        :address2 => "Address2",
        :city => "City",
        :state => "State",
        :country => "Country",
        :zip => "Zip",
        :reference_transaction => "Reference Transaction"
      ),
      stub_model(CreditCard,
        :researcher_id => 1,
        :first_name => "First Name",
        :last_name => "Last Name",
        :number => "Number",
        :month => "Month",
        :year => "Year",
        :ctype => "Ctype",
        :cvv => "Cvv",
        :address1 => "Address1",
        :address2 => "Address2",
        :city => "City",
        :state => "State",
        :country => "Country",
        :zip => "Zip",
        :reference_transaction => "Reference Transaction"
      )
    ])
  end

  it "renders a list of credit_cards" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Number".to_s, :count => 2
    assert_select "tr>td", :text => "Month".to_s, :count => 2
    assert_select "tr>td", :text => "Year".to_s, :count => 2
    assert_select "tr>td", :text => "Ctype".to_s, :count => 2
    assert_select "tr>td", :text => "Cvv".to_s, :count => 2
    assert_select "tr>td", :text => "Address1".to_s, :count => 2
    assert_select "tr>td", :text => "Address2".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => "Reference Transaction".to_s, :count => 2
  end
end
