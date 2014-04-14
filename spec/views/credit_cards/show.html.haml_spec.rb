require 'spec_helper'

describe "credit_cards/show" do
  before(:each) do
    @credit_card = assign(:credit_card, stub_model(CreditCard,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Number/)
    rendered.should match(/Month/)
    rendered.should match(/Year/)
    rendered.should match(/Ctype/)
    rendered.should match(/Cvv/)
    rendered.should match(/Address1/)
    rendered.should match(/Address2/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Country/)
    rendered.should match(/Zip/)
    rendered.should match(/Reference Transaction/)
  end
end
