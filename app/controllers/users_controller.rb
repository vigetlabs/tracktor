class UsersController < ApplicationController

  def index
    redirect_to "/home" if logged_in?
  end

  def show
    redirect_to "/" if !logged_in?
  end

  def create
    user = User.oauth_create(params[:code])
    cookies.permanent[:user_token] = user.token

    redirect_to "/"
  end

  def destroy
    cookies.delete(:user_token)

    redirect_to "/"
  end
end
