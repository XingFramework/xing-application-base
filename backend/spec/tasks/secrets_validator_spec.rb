
require 'spec_helper'
require 'tasks/secrets_validator'

describe SecretsValidator do


  before do
    expect(File).to receive(:open).and_return(nil)
  end

  let :dev_yaml do
    YAML.load(FIXTURE)
  end

  it "when development has a missing key" do
    expect(YAML).to receive(:load).and_return(dev_yaml.deep_merge({'development' => { 'email' => nil }}))
    validator = SecretsValidator.new
    validator.validate('development')
    validator.errors['development'].should_not be_blank
    validator.errors['test'].should be_blank
  end
  it "when development has no missing keys" do
    expect(YAML).to receive(:load).and_return(dev_yaml)
    validator = SecretsValidator.new
    validator.validate('development')
    validator.errors.should be_blank
  end
  it "when development has a missing key and test has a misformatted value " do
    expect(YAML).to receive(:load).and_return(dev_yaml.deep_merge({
      'development' => { 'email' => nil },
      'test'        => { 'email' => { 'from' => 'not_an_email' } }})
    )
    validator = SecretsValidator.new
    validator.validate('development')
    validator.errors['development']['email'] .should_not be_blank
    validator.errors['test']['email']['from'].should_not be_blank
  end


  FIXTURE = <<EOS
development:
  secret_key_base: xxxkey
  smtp:
    address: smtp.gmail.com
    port: 587
    domain: lrdesign.com
    user_name: quentin@lrdesign.com
    password: xxxxxxxx
  email:
    from: quentin@lrdesign.com
    reply_to: quentin@lrdesign.com
    from_domain: lrdesign.com
    test: test@lrdesign.com
  snapshot_server:
    url: https://www.notaserver.com
    user: user
    password: password
  sitemap_base_url: http://localhost:3000/

test:
  secret_key_base: xxkey
  smtp:
    address: smtp.gmail.com
    port: 587
    domain: equibid.com
    user_name: sysquentin@equibid.com
    password: xxxxxxxx
  email:
    from: quentin@example.com
    reply_to: quentin@example.com
    from_domain: lrdesign.com
    test: test@lrdesign.com
  snapshot_server:
    url: https://www.notaserver.com
    user: user
    password: password
  sitemap_base_url: http://localhost:3000/
EOS

end
