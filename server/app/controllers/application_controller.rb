require 'authenticated_system'

class ApplicationController < ActionController::Base
  protect_from_forgery

  include AuthenticatedSystem
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
