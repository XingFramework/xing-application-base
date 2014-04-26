class UsersController < JsonController

  def show
    @user = User.find_by_email(params[:email])
    if @user.present?
      render :json => @user
    else
      render :json => {:error => 'Not Found'}, :status => 404
    end
  end

  #private

    # Never trust parameters from the scary internet, only allow the white list through.
    #def user_params
      #params.require(:user).permit(:first_name, :email, :password, :paypal_email, :gender, :yob, :country, :zip, :time_zone, :type, :rating_cache, :facebook_uid, :crypted_password, :password_salt, :persistence_token, :perishable_token, :single_access_token, :login_count, :failed_login_count, :last_request_at, :current_login_at, :last_login_at, :current_login_ip, :last_login_ip, :public_token, :created_at, :updated_at, :company, :city, :state, :status, :phone, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at, :last_name, :mailer_setting, :dob, :blacklist, :disable_email)
    #end
end
