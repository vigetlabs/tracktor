class Button < ActiveRecord::Base

  has_many :time_entries, :dependent => :destroy

  belongs_to :task
  belongs_to :user

  # has_one :time_entry
  def existing_time_entry
    @existing_time_entry ||= TimeEntry.for_today.find_by({
      button_id: id,
      task_id:   task_id
    })
  end

  def new_time_entry
    TimeEntryCreator.new(self).create
  end

  def new_running_time_entry(running_timer)
    time_entries.create({
      date:       Date.current,
      harvest_id: running_timer.id,
      task:       task
    })
  end
end
