
class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery
  before_filter :check_format

  def check_format
    if request.headers["Accept"] =~ /json/
      params[:format] = :json
    else
      render :nothing => true, :status => 406
    end
  end
end