class TimeEntryCreator

  def initialize(button)
    @button = button
  end

  def create
    if existing_harvest_timer
      TimeEntryToggler.new(new_time_entry).on
    else
      new_time_entry
    end
  end

  private

  def new_time_entry
    TimeEntry.create({
      date:       Date.current,
      harvest_id: harvest_timer.id,
      button:     @button,
      task:       @button.task
    })
  end

  def harvest_timer
    existing_harvest_timer || new_harvest_timer
  end

  def new_harvest_timer
    client.time.create({
      "project_id" => project.harvest_id, "task_id" => task.harvest_id
    })
  end

  def existing_harvest_timer
    return @existing_harvest_timer if defined? @existing_harvest_timer

    @existing_harvest_timer = client.time.all(Time.zone.now).detect do |timer|
      timer.project_id.to_i == project.harvest_id &&
      timer.task_id.to_i    == task.harvest_id
    end
  end

  def project
    task.project
  end

  def task
    @task ||= @button.task
  end

  def client
    @button.user.client
  end

end
