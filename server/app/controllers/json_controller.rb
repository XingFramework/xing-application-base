class JsonController < ActionController::Base
  respond_to :json

  def json_body
    @json_body ||= request.body.read
  end

  def parse_json
    @parsed_json ||= JSON.parse(json_body)
  end
end