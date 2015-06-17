class Admin::AdminController < ApplicationController
  before_filter :reject_if_not_logged_in

  def reject_if_not_logged_in
    unless current_user
      render :json => {}, status: 401
    end
  end
end
