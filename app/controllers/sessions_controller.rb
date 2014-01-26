require 'soundcloud_interface'

class SessionsController < ApplicationController
  skip_before_filter :require_user, only: [:new, :create, :auth]

  def auth
    redirect_to SoundcloudInterface.authorize_url
  end

  def create
    token_response = SoundcloudInterface.get_token params[:code]
    user = User.find_or_create_by_token(token_response['access_token'])
    SoundcloudInterface.set_client user.access_token
    session[:user_id] = user.id
    gflash :success => "Logged in as #{current_user.username}"
    redirect_to dashboard_path
  end

  def destroy
    if current_user
      gflash :success => "You have successfully logged out."
    end
    session[:user_id] = nil 
    redirect_to login_path
  end

  def new
    if current_user
      gflash :success => "You are already logged in with Soundcloud."
      redirect_to dashboard_path
    end
  end

end
