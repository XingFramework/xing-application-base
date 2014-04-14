require 'spec_helper'

describe "transactions/edit" do
  before(:each) do
    @transaction = assign(:transaction, stub_model(Transaction,
      :what_id => 1,
      :what_type => "MyString",
      :amount => 1,
      :note => "MyText",
      :user_id => 1,
      :payment_method => "MyString",
      :reference => "MyString",
      :authorization => "MyString",
      :study_id => 1,
      :category => 1
    ))
  end

  it "renders the edit transaction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", transaction_path(@transaction), "post" do
      assert_select "input#transaction_what_id[name=?]", "transaction[what_id]"
      assert_select "input#transaction_what_type[name=?]", "transaction[what_type]"
      assert_select "input#transaction_amount[name=?]", "transaction[amount]"
      assert_select "textarea#transaction_note[name=?]", "transaction[note]"
      assert_select "input#transaction_user_id[name=?]", "transaction[user_id]"
      assert_select "input#transaction_payment_method[name=?]", "transaction[payment_method]"
      assert_select "input#transaction_reference[name=?]", "transaction[reference]"
      assert_select "input#transaction_authorization[name=?]", "transaction[authorization]"
      assert_select "input#transaction_study_id[name=?]", "transaction[study_id]"
      assert_select "input#transaction_category[name=?]", "transaction[category]"
    end
  end
end
