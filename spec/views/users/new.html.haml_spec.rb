require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :first_name => "MyString",
      :email => "MyString",
      :password => "MyString",
      :paypal_email => "MyString",
      :gender => 1,
      :yob => 1,
      :country => "MyString",
      :zip => "MyString",
      :time_zone => "MyString",
      :type => "",
      :rating_cache => 1.5,
      :facebook_uid => 1,
      :crypted_password => "MyString",
      :password_salt => "MyString",
      :persistence_token => "MyString",
      :perishable_token => "MyString",
      :single_access_token => "MyString",
      :login_count => 1,
      :failed_login_count => 1,
      :current_login_ip => "MyString",
      :last_login_ip => "MyString",
      :public_token => "MyString",
      :company => "MyString",
      :city => "MyString",
      :state => "MyString",
      :status => 1,
      :phone => "MyString",
      :photo_file_name => "MyString",
      :photo_content_type => "MyString",
      :photo_file_size => 1,
      :last_name => "MyString",
      :mailer_setting => 1,
      :blacklist => false,
      :disable_email => false
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", users_path, "post" do
      assert_select "input#user_first_name[name=?]", "user[first_name]"
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "input#user_password[name=?]", "user[password]"
      assert_select "input#user_paypal_email[name=?]", "user[paypal_email]"
      assert_select "input#user_gender[name=?]", "user[gender]"
      assert_select "input#user_yob[name=?]", "user[yob]"
      assert_select "input#user_country[name=?]", "user[country]"
      assert_select "input#user_zip[name=?]", "user[zip]"
      assert_select "input#user_time_zone[name=?]", "user[time_zone]"
      assert_select "input#user_type[name=?]", "user[type]"
      assert_select "input#user_rating_cache[name=?]", "user[rating_cache]"
      assert_select "input#user_facebook_uid[name=?]", "user[facebook_uid]"
      assert_select "input#user_crypted_password[name=?]", "user[crypted_password]"
      assert_select "input#user_password_salt[name=?]", "user[password_salt]"
      assert_select "input#user_persistence_token[name=?]", "user[persistence_token]"
      assert_select "input#user_perishable_token[name=?]", "user[perishable_token]"
      assert_select "input#user_single_access_token[name=?]", "user[single_access_token]"
      assert_select "input#user_login_count[name=?]", "user[login_count]"
      assert_select "input#user_failed_login_count[name=?]", "user[failed_login_count]"
      assert_select "input#user_current_login_ip[name=?]", "user[current_login_ip]"
      assert_select "input#user_last_login_ip[name=?]", "user[last_login_ip]"
      assert_select "input#user_public_token[name=?]", "user[public_token]"
      assert_select "input#user_company[name=?]", "user[company]"
      assert_select "input#user_city[name=?]", "user[city]"
      assert_select "input#user_state[name=?]", "user[state]"
      assert_select "input#user_status[name=?]", "user[status]"
      assert_select "input#user_phone[name=?]", "user[phone]"
      assert_select "input#user_photo_file_name[name=?]", "user[photo_file_name]"
      assert_select "input#user_photo_content_type[name=?]", "user[photo_content_type]"
      assert_select "input#user_photo_file_size[name=?]", "user[photo_file_size]"
      assert_select "input#user_last_name[name=?]", "user[last_name]"
      assert_select "input#user_mailer_setting[name=?]", "user[mailer_setting]"
      assert_select "input#user_blacklist[name=?]", "user[blacklist]"
      assert_select "input#user_disable_email[name=?]", "user[disable_email]"
    end
  end
end
