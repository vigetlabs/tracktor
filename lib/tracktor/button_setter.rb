class ButtonSetter

  def initialize(params, user)
    @params = params
    @user   = user
  end

  def set
    button_params.each do |button_identifier, task_id|
      number = button_identifier.split("-").last.to_i
      button = @user.buttons.where(number: number).first_or_create

      button.update_attributes(:task => Task.find(task_id))
    end
  end

  private

  def button_params
    @params.select { |key, _| key.include? "button-" }
  end
end
