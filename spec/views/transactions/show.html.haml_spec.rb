require 'spec_helper'

describe "transactions/show" do
  before(:each) do
    @transaction = assign(:transaction, stub_model(Transaction,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/What Type/)
    rendered.should match(/2/)
    rendered.should match(/MyText/)
    rendered.should match(/3/)
    rendered.should match(/Payment Method/)
    rendered.should match(/Reference/)
    rendered.should match(/Authorization/)
    rendered.should match(/4/)
    rendered.should match(/5/)
  end
end
