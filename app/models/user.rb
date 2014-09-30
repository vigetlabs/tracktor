class User < ActiveRecord::Base

  before_create :generate_token

  has_many :projects, :dependent => :destroy
  has_many :tasks,    :through => :projects

  has_many :buttons,      :dependent => :destroy
  has_many :time_entries, :through => :buttons

  def self.oauth_create(oauth_code)
    tokens = HTTParty.post("https://api.harvestapp.com/oauth2/token", :body => {
      code:          oauth_code,
      client_id:     Harvest::CLIENT_ID,
      client_secret: Harvest::CLIENT_SECRET,
      redirect_uri:  Harvest::REDIRECT_URI,
      grant_type:    "authorization_code"
    })

    who_am_i = Harvest.client(access_token: tokens["access_token"]).account.who_am_i

    user_params = {
      harvest_access_token:  tokens["access_token"],
      harvest_refresh_token: tokens["refresh_token"],
      email:                 who_am_i.email,
      full_name:             who_am_i.first_name + " " +  who_am_i.last_name
    }

    if user = find_by(email: user_params[:email])
      user.update_attributes(user_params)
    else
      user = create(user_params)
      HarvestSeeder.seed_projects_and_tasks(user)
    end

    user
  end

  def update_token
    tokens = HTTParty.post("https://api.harvestapp.com/oauth2/token", :body => {
      refresh_token: harvest_refresh_token,
      client_id:     Harvest::CLIENT_ID,
      client_secret: Harvest::CLIENT_SECRET,
      grant_type:    "refresh_token"
    })

    update_attributes({
      harvest_access_token:  tokens["access_token"],
      harvest_refresh_token: tokens["refresh_token"]
    })
  end

  def client
    @client ||= Harvest.client(access_token: harvest_access_token)
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(5)
  end

end
