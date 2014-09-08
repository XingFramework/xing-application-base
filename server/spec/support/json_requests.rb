module JSONRequests

  def json_get(url, arg2 = nil)
    get url, arg2, { 'HTTP_ACCEPT' => 'application/json' }
  end
end

module RSpec::Rails::RequestExampleGroup
  include JSONRequests
end
