class Project < ActiveRecord::Base

  belongs_to :user
  has_many :tasks, :dependent => :destroy

  def self.first_or_create(project_hash, user)
    where(harvest_id: project_hash["id"], user_id: user.id).first_or_create({
      name:        project_hash["name"],
      harvest_id:  project_hash["id"],
      client_name: project_hash["client"],
      user_id:     user.id
    })
  end

end
