module Requests
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
    end

    def set_json_request
      request.accept = 'application/json'
    end

    def json_get(path, params=nil)
      get path, params, { HTTP_ACCEPT: 'application/json' }
    end
  end
end
