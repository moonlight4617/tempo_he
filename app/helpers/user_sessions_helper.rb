module UserSessionsHelper
  def remember(user)
    user.save_remember_digest
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])
      @user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        session[:user_id] = user.id
        @user = user
      end
    end
  end

  def logged_in?
    session[:user_id] != nil
  end

  def forget(user)
    user.forget_remember_digest
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(@user)
    session.delete(:user_id)
    @user = nil
  end

end
