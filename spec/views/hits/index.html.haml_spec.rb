require 'spec_helper'

describe "hits/index" do
  before(:each) do
    assign(:hits, [
      stub_model(Hit,
        :user_id => 1,
        :ip => "Ip",
        :request => "MyText",
        :params => "MyText"
      ),
      stub_model(Hit,
        :user_id => 1,
        :ip => "Ip",
        :request => "MyText",
        :params => "MyText"
      )
    ])
  end

  it "renders a list of hits" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Ip".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
