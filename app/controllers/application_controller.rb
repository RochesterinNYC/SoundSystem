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

  def duration_string num_milliseconds
    
    hours = num_milliseconds / 3600000
    num_milliseconds = num_milliseconds % 3600000

    minutes = num_milliseconds / 60000
    num_milliseconds = num_milliseconds % 60000

    seconds = num_milliseconds / 1000

    duration = ""
    duration = duration + "#{hours} hours" if hours > 0
    duration = duration + ", " unless minutes == 0 || hours == 0
    duration = duration + "#{minutes} minutes" if minutes > 0
    duration = duration + ", " unless seconds == 0
    duration = duration + "#{seconds} seconds" if seconds > 0

    duration
  end
  helper_method :duration_string

end
