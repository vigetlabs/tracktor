module ApplicationHelper

  def oauth_url
    "https://api.harvestapp.com/oauth2/authorize?client_id=#{CGI.escape(Harvest::CLIENT_ID)}&redirect_uri=#{Harvest::REDIRECT_URI}&response_type=code"
  end
end
