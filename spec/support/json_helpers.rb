module JsonHelpers

  module Controllers
    def set_json_request(params = {})
      if params.present? and params[:owner_id]
        request.headers['X-Owner-Id'] = params[:owner_id].to_s
      end
      request.headers['HTTP_ACCEPT'] = 'application/json'
      request.headers['Content-Type'] = 'application/json'
    end
  end

  module Requests
    JSON_HEADERS = { 'HTTP_ACCEPT' => 'application/json',
      'Content-Type' => 'application/json'
    }

    def json_get(path, params, options = nil)
      get path, params, json_headers(options)
    end

    def json_post(path, params, options =nil)
      post path, params, json_headers(options)
    end

    def json_headers(options)
      options ||= {}
      if self.respond_to?(:current_user)
        options[:user_id] = current_user.id if current_user.present?
      end
      JSON_HEADERS.tap do |headers|
        headers['X-User-Id'] = options[:user_id].to_s if options[:user_id]
      end
    end
  end

  def json
    @json ||= JSON.parse(response.body)
  end

  def add_to_json(json, options)
    JSON.parse(json).deep_merge(options).to_json
  end

  #def json_headers(params)
  #{ HTTP_ACCEPT: 'application/json' }.tap do |headers|
  #if owner_id = params.delete[:owner_id]
  #headers.merge!('X-Owner-Id' =>  owner_id)
  #end
  #p headers
  #end
  #end

  def json_fixture(path)
    File.open(File.join(Rails.root, 'spec', 'fixtures', 'json', path)).read
  end
end
