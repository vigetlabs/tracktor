class TimeEntryToggler

  def initialize(time_entry)
    @time_entry = time_entry
  end

  # returns true  if timer is on
  # returns false if timer is off
  def toggle
    client.time.toggle(@time_entry.harvest_id).timer_started_at.present?
  end

  def on
    toggle if timer_off
  end

  private

  def timer_off
    client.time.find(@time_entry.harvest_id).timer_started_at.nil?
  end

  def client
    @time_entry.user.client
  end
end
