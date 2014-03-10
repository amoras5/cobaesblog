module SessionsHelper
  
  def sign_in(user)
  	cookies.permanent[:remember_token] = user.remember_token
  	self.current_user = user
  end

  def sign_in_temp(user)
    cookies[:remember_token] = { value: user.remember_token, expires: 1.minute.from_now }
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
  	@current_user = user
  end

  def current_user
  	@current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end

  def current_article
    @current_article ||= Article.find_by_id(params[:id])
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in? || current_user.admin?
       store_location
       redirect_to signin_path, notice: "Primero tiene que identificarse como usuario."
    end
  end
  
  def signed_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end