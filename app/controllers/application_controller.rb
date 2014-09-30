class ApplicationController < ActionController::Base

  helper_method :current_user

  private

  def logged_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(token: cookies["user_token"])
  end

end
