module SessionsHelper
  def sign_in(user)
    # not so permanent: "only" 20 years from now...
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  # method with = are expressly designed to handle assignment to a variable (current_user here)
  def current_user=(user)
    @current_user = user
  end

  # get the current user by using its remember_token
  def current_user
    # this is equivalent to the next instruction: @current_user = @current_user || User.find_by_remember_token(cookies[:remember_token])
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  # friendly forwarding: when users try to access a protected page, without this method, they are redirected to their profile pages regardless of where they were trying to go; with such a method, they arrive to their intended destination instead
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end

end
