class RunningTimer

  def self.find(user)
    new(user).find
  end

  def initialize(user)
    @user = user
  end

  def find
    if running_timer && time_entry
      time_entry.button.number
    else
      "off"
    end
  end

  private

  def time_entry
    @time_entry ||= existing_time_entry || new_time_entry
  end

  def existing_time_entry
    @user.time_entries.find_by(harvest_id: running_timer.id)
  end

  def new_time_entry
    matching_button.try(:new_running_time_entry, running_timer)
  end

  def matching_button
    @user.buttons.find_by(task: matching_task)
  end

  def matching_task
    Task.where(harvest_id: running_timer.task_id, project: matching_project)
  end

  def matching_project
    @user.projects.find_by(harvest_id: running_timer.project_id)
  end

  def running_timer
    @running_timer ||= client.time.all(Time.zone.now).detect(&:timer_started_at)
  end

  def client
    @user.client
  end
end
