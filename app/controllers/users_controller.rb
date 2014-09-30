class UsersController < ApplicationController

  def index
    redirect_to "/home" if logged_in?
  end

  def show
    redirect_to "/" if !logged_in?
  end

  def create
    code = params[:code]

    tokens = HTTParty.post("https://api.harvestapp.com/oauth2/token", :body => {
      code:          code,
      client_id:     Harvest::CLIENT_ID,
      client_secret: Harvest::CLIENT_SECRET,
      redirect_uri:  Harvest::REDIRECT_URI,
      grant_type:    "authorization_code"
    })

    who_am_i = HTTParty.get("https://api.harvestapp.com/account/who_am_i?access_token=#{tokens["access_token"]}",
      :headers => {
        "Content-Type" => "application/json",
        "Accept"       => "application/json"
      })

    user_params = {
      harvest_access_token:  tokens["access_token"],
      harvest_refresh_token: tokens["refresh_token"],
      email:                 who_am_i["user"]["email"],
      full_name:             who_am_i["user"]["first_name"] + " " +  who_am_i["user"]["last_name"]
    }

    user = User.where(email: user_params[:email]).first_or_create
    user.update_attributes(user_params)

    cookies.permanent[:user_token] = user.token

    redirect_to "/"
  end

  def destroy
    cookies.delete(:user_token)

    redirect_to "/"
  end
end
