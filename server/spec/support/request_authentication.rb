module RequestAuthentication
  def login!(user)
    UserSession.create user
    cookies['user_credentials'] = "#{user.persistence_token}::#{user.send(user.class.primary_key)}"
  end

  def logout!
    UserSession.find.destroy
  end
end