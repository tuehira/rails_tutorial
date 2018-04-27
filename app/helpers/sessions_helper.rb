module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user
    logger.debug "▶︎current_user debug"
    if (user_id = session[:user_id])
      logger.debug "session-if"
      @current_user ||= User.find_by(id: user_id)
      logger.debug @current_user.name
      logger.debug "session-if-success"
    elsif (user_id = cookies.signed[:user_id])
      logger.debug "cookies-if"
      logger.debug user_id
      user = User.find_by(id: user_id)
      logger.debug user.name
      puts cookies[:remember_token]
      if user
        if user.authenticated?(cookies[:remember_token])
          log_in user
          @current_user = user
        else
          puts user.authenticated?(cookies[:remember_token])
          puts cookies[:remember_token]
          p user
        end
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
