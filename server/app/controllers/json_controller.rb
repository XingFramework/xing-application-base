class JsonController < ActionController::Base
  respond_to :json

  def json_body
    @json_body ||= request.body.read
  end

  def parse_json
    @parsed_json ||= JSON.parse(json_body)
  end

  def current_user
    @current_user ||= set_user
  end

  private
  def set_user
    return unless request.headers['X-User-Id']
    @user_id = request.headers['X-User-Id']
    @current_user = User.find(@user_id)
  end
end