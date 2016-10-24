require './lib/twitter_utils/twitter_client'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to log_in_path unless current_user
  end

  def twitter_client
    @twitter_client ||= TwitterUtils::TwitterClient.new
  end
end
