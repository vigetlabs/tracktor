class HarvestSeeder

  def self.seed(user)
    seeder = new(user)

    seeder.seed_projects_and_tasks
    seeder.clear_stale_records
  end

  def initialize(user)
    @user = user
  end

  def seed_projects_and_tasks
    harvest_data.each do |project_json|
      project = Project.first_or_create(project_json, @user)

      project_json["tasks"].each do |task_json|
        Task.first_or_create(task_json.merge("project_id" => project.id))
      end
    end
  end

  def clear_stale_records
    project_ids = harvest_data.map{|p| p["id"]}

    @user.projects.each do |project|
      project.destroy unless project_ids.include?(project.harvest_id)

      begin
        project_tasks = harvest_data.detect{|p| p["id"] == project.harvest_id}["tasks"]
        task_ids      = project_tasks.map{|t| t["id"]}

        project.tasks.each do |task|
          task.destroy unless task_ids.include?(task.harvest_id)
        end

      rescue
        project.destroy
      end
    end
  end

  private

  def harvest_data
    @harvest_data ||= response["projects"]
  end

  def response
    JSON.parse(raw_response.parsed_response)
  end

  def raw_response
    client.projects.send(:request, :get, client.credentials, "/daily")
  end

  def client
    @user.client
  end
end
