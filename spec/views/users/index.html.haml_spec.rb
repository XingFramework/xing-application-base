require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :first_name => "First Name",
        :email => "Email",
        :password => "Password",
        :paypal_email => "Paypal Email",
        :gender => 1,
        :yob => 2,
        :country => "Country",
        :zip => "Zip",
        :time_zone => "Time Zone",
        :type => "Type",
        :rating_cache => 1.5,
        :facebook_uid => 3,
        :crypted_password => "Crypted Password",
        :password_salt => "Password Salt",
        :persistence_token => "Persistence Token",
        :perishable_token => "Perishable Token",
        :single_access_token => "Single Access Token",
        :login_count => 4,
        :failed_login_count => 5,
        :current_login_ip => "Current Login Ip",
        :last_login_ip => "Last Login Ip",
        :public_token => "Public Token",
        :company => "Company",
        :city => "City",
        :state => "State",
        :status => 6,
        :phone => "Phone",
        :photo_file_name => "Photo File Name",
        :photo_content_type => "Photo Content Type",
        :photo_file_size => 7,
        :last_name => "Last Name",
        :mailer_setting => 8,
        :blacklist => false,
        :disable_email => false
      ),
      stub_model(User,
        :first_name => "First Name",
        :email => "Email",
        :password => "Password",
        :paypal_email => "Paypal Email",
        :gender => 1,
        :yob => 2,
        :country => "Country",
        :zip => "Zip",
        :time_zone => "Time Zone",
        :type => "Type",
        :rating_cache => 1.5,
        :facebook_uid => 3,
        :crypted_password => "Crypted Password",
        :password_salt => "Password Salt",
        :persistence_token => "Persistence Token",
        :perishable_token => "Perishable Token",
        :single_access_token => "Single Access Token",
        :login_count => 4,
        :failed_login_count => 5,
        :current_login_ip => "Current Login Ip",
        :last_login_ip => "Last Login Ip",
        :public_token => "Public Token",
        :company => "Company",
        :city => "City",
        :state => "State",
        :status => 6,
        :phone => "Phone",
        :photo_file_name => "Photo File Name",
        :photo_content_type => "Photo Content Type",
        :photo_file_size => 7,
        :last_name => "Last Name",
        :mailer_setting => 8,
        :blacklist => false,
        :disable_email => false
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
    assert_select "tr>td", :text => "Paypal Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => "Time Zone".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Crypted Password".to_s, :count => 2
    assert_select "tr>td", :text => "Password Salt".to_s, :count => 2
    assert_select "tr>td", :text => "Persistence Token".to_s, :count => 2
    assert_select "tr>td", :text => "Perishable Token".to_s, :count => 2
    assert_select "tr>td", :text => "Single Access Token".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Current Login Ip".to_s, :count => 2
    assert_select "tr>td", :text => "Last Login Ip".to_s, :count => 2
    assert_select "tr>td", :text => "Public Token".to_s, :count => 2
    assert_select "tr>td", :text => "Company".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Photo File Name".to_s, :count => 2
    assert_select "tr>td", :text => "Photo Content Type".to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
