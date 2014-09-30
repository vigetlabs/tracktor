class HomeController < ApplicationController

  def index
    redirect_to "/home" if logged_in?
  end

  def show
    redirect_to "/" if !logged_in?
  end
end
