class ParamsHandler

  def initialize(params, user)
    @params = params
    @user   = user
  end

  def update
    update_core_id
    update_buttons
  end

  private

  def update_core_id
    if @params[:core_id].present?
      @user.update_attributes(core_id: @params[:core_id])
    end
  end

  def update_buttons
    button_params.each do |button_identifier, task_id|
      number = button_identifier.split("-").last.to_i
      button = @user.buttons.where(number: number).first_or_create

      button.update_attributes(task: Task.find(task_id))
    end
  end

  def button_params
    @params.select { |key, _| key.include? "button-" }
  end
end
