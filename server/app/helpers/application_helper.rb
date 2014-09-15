
module ApplicationHelper

  def logged_in?
    current_user
  end

  def admin?
    logged_in?
  end

end
