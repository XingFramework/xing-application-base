module JSONRequests

  def json_get(url, arg2 = nil)
    get url, arg2, { 'HTTP_ACCEPT' => 'application/json' }
  end

  def json_post(url, arg2 = nil)
    post url, arg2, { 'HTTP_ACCEPT' => 'application/json' }
  end

  def json_put(url, arg2 = nil)
    put url, arg2, { 'HTTP_ACCEPT' => 'application/json' }
  end
end

module RSpec::Rails::RequestExampleGroup
  include JSONRequests
  include JsonSpec::Matchers
end


