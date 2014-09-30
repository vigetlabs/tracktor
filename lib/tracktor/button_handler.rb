class ButtonHandler

  def self.handle(pressed_button, user)
    new(pressed_button, user).handle
  end

  def initialize(pressed_button, user)
    @pressed_button = pressed_button
    @user           = user
  end

  def handle
    if button && existing_time_entry
      { success: true, on: toggle_timer(existing_time_entry) }
    elsif button && button.new_time_entry
      { success: true, on: true }
    else
      { success: false }
    end
  end

  private

  def toggle_timer(time_entry)
    TimeEntryToggler.new(time_entry).toggle
  end

  def existing_time_entry
    @existing_time_entry ||= button.existing_time_entry
  end

  def button
    @button ||= Button.find_by(number: @pressed_button, user: @user)
  end

end
