class ApplicationController < ActionController::Base

  helper_method :current_user

  private

  def logged_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(token: cookies["user_token"])
  end

  def token_user
    User.find_by(token: params[:token])
  end

  def require_login
    redirect "/" unless logged_in?
  end

  def reset_cookie(user)
    response.set_cookie("user_token", {
      :value   => user.token,
      :max_age => "15552000" # 12 months
    })

    user.update_token
  end

end
