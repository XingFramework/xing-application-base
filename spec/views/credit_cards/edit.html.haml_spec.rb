require 'spec_helper'

describe "credit_cards/edit" do
  before(:each) do
    @credit_card = assign(:credit_card, stub_model(CreditCard,
      :researcher_id => 1,
      :first_name => "MyString",
      :last_name => "MyString",
      :number => "MyString",
      :month => "MyString",
      :year => "MyString",
      :ctype => "MyString",
      :cvv => "MyString",
      :address1 => "MyString",
      :address2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :country => "MyString",
      :zip => "MyString",
      :reference_transaction => "MyString"
    ))
  end

  it "renders the edit credit_card form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", credit_card_path(@credit_card), "post" do
      assert_select "input#credit_card_researcher_id[name=?]", "credit_card[researcher_id]"
      assert_select "input#credit_card_first_name[name=?]", "credit_card[first_name]"
      assert_select "input#credit_card_last_name[name=?]", "credit_card[last_name]"
      assert_select "input#credit_card_number[name=?]", "credit_card[number]"
      assert_select "input#credit_card_month[name=?]", "credit_card[month]"
      assert_select "input#credit_card_year[name=?]", "credit_card[year]"
      assert_select "input#credit_card_ctype[name=?]", "credit_card[ctype]"
      assert_select "input#credit_card_cvv[name=?]", "credit_card[cvv]"
      assert_select "input#credit_card_address1[name=?]", "credit_card[address1]"
      assert_select "input#credit_card_address2[name=?]", "credit_card[address2]"
      assert_select "input#credit_card_city[name=?]", "credit_card[city]"
      assert_select "input#credit_card_state[name=?]", "credit_card[state]"
      assert_select "input#credit_card_country[name=?]", "credit_card[country]"
      assert_select "input#credit_card_zip[name=?]", "credit_card[zip]"
      assert_select "input#credit_card_reference_transaction[name=?]", "credit_card[reference_transaction]"
    end
  end
end
