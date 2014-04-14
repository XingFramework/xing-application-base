require 'spec_helper'

describe "transactions/index" do
  before(:each) do
    assign(:transactions, [
      stub_model(Transaction,
        :what_id => 1,
        :what_type => "What Type",
        :amount => 2,
        :note => "MyText",
        :user_id => 3,
        :payment_method => "Payment Method",
        :reference => "Reference",
        :authorization => "Authorization",
        :study_id => 4,
        :category => 5
      ),
      stub_model(Transaction,
        :what_id => 1,
        :what_type => "What Type",
        :amount => 2,
        :note => "MyText",
        :user_id => 3,
        :payment_method => "Payment Method",
        :reference => "Reference",
        :authorization => "Authorization",
        :study_id => 4,
        :category => 5
      )
    ])
  end

  it "renders a list of transactions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "What Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Payment Method".to_s, :count => 2
    assert_select "tr>td", :text => "Reference".to_s, :count => 2
    assert_select "tr>td", :text => "Authorization".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
