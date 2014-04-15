require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First Name/)
    rendered.should match(/Email/)
    rendered.should match(/Password/)
    rendered.should match(/Paypal Email/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Country/)
    rendered.should match(/Zip/)
    rendered.should match(/Time Zone/)
    rendered.should match(/Type/)
    rendered.should match(/1.5/)
    rendered.should match(/3/)
    rendered.should match(/Company/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/6/)
    rendered.should match(/Phone/)
    rendered.should match(/Photo File Name/)
    rendered.should match(/Photo Content Type/)
    rendered.should match(/7/)
    rendered.should match(/Last Name/)
  end
end
