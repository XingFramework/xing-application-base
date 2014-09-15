
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

  include UrlHelper

  def store_location
    session[:return_to] = request.fullpath
  end

  def after_sign_in_path_for(resource)
    return_path = session[:return_to]
    session[:return_to] = nil
    return_path || root_path
  end

end
