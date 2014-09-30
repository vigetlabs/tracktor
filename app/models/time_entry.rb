class TimeEntry < ActiveRecord::Base
  belongs_to :task
  belongs_to :button
  has_one :user, :through => :button

  scope :for_today, -> { where(date: Date.current) }

  def self.clean
    where("date < ?", Date.current).destroy_all
  end
end
