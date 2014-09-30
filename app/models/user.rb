class User < ActiveRecord::Base

  before_create :generate_token

  def update_token
    tokens = HTTParty.post("https://api.harvestapp.com/oauth2/token", :body => {
      :refresh_token => harvest_refresh_token,
      :client_id     => Harvest::CLIENT_ID,
      :client_secret => Harvest::CLIENT_SECRET,
      :grant_type    => "refresh_token"
    })

    update_attributes({
      :harvest_access_token  => tokens["access_token"],
      :harvest_refresh_token => tokens["refresh_token"]
    })
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(5)
  end

end
