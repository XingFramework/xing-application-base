
require 'spec_helper'
require 'rake'
#require 'pp'
#pp $:
require 'tasks/dependencies_common.rake'

describe SecretsValidator do


  before do
    expect(File).to_receive(:open).and_return(nil)
  end

  let :dev_yaml do
    YAML.load(FIXTURE)
  end

  it "when development has a missing key" do
    expect(YAML).to_receive(:load).and_return(dev_yaml.delete!(email))
    validator = SecretsValidator.new
    validator.validate_dev
    validator.errors.should_not be_blank
  end
  it "when development has no missing keys" do
    expect(YAML).to_receive(:load).and_return(dev_yaml)
    validator = SecretsValidator.new
    validator.validate_dev
    validator.errors.should be_blank
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
