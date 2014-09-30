class Task < ActiveRecord::Base

  belongs_to :project

  def self.first_or_create(task_hash)
    where(harvest_id: task_hash["id"], project_id: task_hash["project_id"]).first_or_create({
      name:       task_hash["name"],
      harvest_id: task_hash["id"],
      project_id: task_hash["project_id"]
    })
  end

end
