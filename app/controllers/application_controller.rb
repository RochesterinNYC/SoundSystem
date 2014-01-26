class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_user
    if current_user
      if !current_user.client_configured
        current_user.initialize_client
      end
      return true
    end
    #gflash :error => "Please login with Soundcloud."
    redirect_to login_path
  end

end
